#!/usr/bin/env ruby
require 'hornetseye'
require 'Qt'
require 'ui_main'
require 'settings'

include Hornetseye

W, H = 640, 480
B = 40
NOISE = 10 * B * B
DECAY = 0.2
THRESHOLD = 1.6
DAMAGE = 10
BONUS_DAMAGE = 5
PLAYER_PRESENT_THRESHOLD = 60
PRESENT_THRESHOLD = 10
PIC_INTERVAL = 8

class GUI < Qt::Widget
  slots 'fight()', 'settings()', 'restart()'
  
  def initialize( parent = nil )
    super( parent )
    
    @ui = Ui::SimulatorWindow.new
    @ui.setupUi self
    @ui.player1PB.setVisible(false)
    @ui.player2PB.setVisible(false)
    @ui.stopBtn.setVisible(false)
    @xvwidget = XvWidget.new
    @ui.scrollArea.widget = @xvwidget
    
    @setting = SETTINGS.new
    
    connect( @ui.quitBtn, SIGNAL( 'clicked()' ), $qApp, SLOT( 'quit()' ) )
    connect( @ui.fightBtn, SIGNAL( 'clicked()' ), self, SLOT( 'fight()' ) )
    connect( @ui.settingsBtn, SIGNAL( 'clicked()' ), self, SLOT( 'settings()' ) )
    connect( @ui.stopBtn, SIGNAL( 'clicked()' ), self, SLOT( 'restart()' ) )
    
    # Initialize global variables
    @timer = 0
    @boxes = [[0 .. 0, 0 .. 0], [ 400 ... 440, 200 ... 240 ], [ 400 ... 440, 80 ... 120 ], [ 400 ... 440, 360 ... 400 ], [ 200 ... 240, 200 ... 240 ], [ 200 ... 240, 80 ... 120 ], [ 200 ... 240, 360 ... 400 ] ]
    @zone = @boxes[0]
    @inputCam.close if @inputCam
    @inputCam = V4L2Input.new '/dev/video0', W, H
    @timer = startTimer 0 if @timer == 0
    @silhouette = MultiArray.load_ubytergb 'silhouette.jpg'
    @warp = MultiArray.int 2, W, H
    idx = MultiArray.int( W, H ).indgen!
    @warp.roll[0] = W - 1 - idx % W
    @warp.roll[1] = idx / W
    
    # Logic game variables
    @attack = nil
    @finished = false
    @successfulAttack = nil
    @successfulDodge = nil
    @start = nil
    @picTurn = false
    @picPath = nil
  end
  
  def fight
    @ui.instructionsLbl.setVisible(false)
    @ui.settingsBtn.setEnabled(false)
    @ui.fightBtn.setEnabled(false)
    @ui.stopBtn.setVisible(true)
    @ui.player1PB.setVisible(true)
    @ui.player2PB.setVisible(true)
    @ui.player1Lbl.setVisible(true)
    @ui.player2Lbl.setVisible(true)
    @ui.timerLbl.setVisible(true)
    @ui.player1Lbl.setText(@setting.getPlayerName)
    @ui.player2Lbl.setText(@setting.getEnemyName)
    if @setting.getTimeout != nil
      @fightTimer = Time.new.to_f
      @ui.timerLbl.setNum(@setting.getTimeout)
    else
      @ui.timerLbl.setText("")
      @fightTimer = nil
    end
    if @setting.getPicturesOn
      @picInterval = Time.new
      @picPath = @setting.getPath
      %x[mkdir -p "#{@picPath}"]
    end
    # Check times and motion thresholds
    @dodgeTime = 0.5 + ( 2 - @setting.getDifficulty ) * 0.25
    @attackTime = 0.6 + (2 - @setting.getDifficulty ) * 0.3
    @path = @setting.getEnemyName + @setting.getDifficulty.to_s
    @inputVideo = XineInput.new "Videos/#{@path}/intro.avi"
    @average = MultiArray.int( W / B, H / B ).fill!
    @videoStart = Time.new.to_f
    @finished = false
    @start = Time.new.strftime("%d%m%Y%k%M%S")
    @previous_img = @inputCam.read_ubyte
    @camBg = @previous_img.dup

    i = Sequence( INT, W / B ).indgen
    j = Sequence( INT, H / B ).indgen
    k = Sequence( INT, B ).indgen
    l = Sequence( INT, B ).indgen
    idx = MultiArray.tensor( 4 ) { |x,y,u,v| i[u] * B + j[v] * B * W + k[x] + l[y] * W }

    @warpMotion = MultiArray.int 2, B, B, W / B, H / B
    @warpMotion.roll[0] = idx % W
    @warpMotion.roll[1] = idx / W
  end
  
  def timerEvent( e )
    if @start == nil
      cam = @inputCam.read_ubytergb
      img = (@silhouette <= 8).conditional( cam, @silhouette )
      @xvwidget.write img.warp( @warp )
    elsif !@picTurn
      begin
        if @picPath != nil and Time.new.to_f - @picInterval.to_f > PIC_INTERVAL
          index = @picInterval.strftime("%d%m%Y%k%M%S").index(" ")
          if index != nil
            time = @picInterval.strftime("%d%m%Y%k%M%S").delete(" ").insert(index, 0.to_s)
          else
            time = @picInterval.strftime("%d%m%Y%k%M%S")
          end
          @imgCam.save_ubytergb @picPath + 'pic' + time + '.jpg'
          @picInterval = Time.new
        end
        # Update the counter and check the winner
        if @fightTimer != nil and Time.new.to_f - @fightTimer > 1
          @ui.timerLbl.setNum(@ui.timerLbl.text.to_i - 1)
          if @ui.timerLbl.text.to_i == 0
            if @ui.player1PB.value > @ui.player2PB.value
              finishGame "finalWinner"
            elsif @ui.player1PB.value < @ui.player2PB.value
              finishGame "finalLoser"
            else
              finishGame "finalDraw"
            end
          end
          if !@finished
            @fightTimer = Time.new.to_f
          end
        end
        
        # Read video and webcam images
        begin
          imgVideo = @inputVideo.read
        end until @inputVideo.pos >= ( Time.new.to_f - @videoStart ) * 1000
        imgVideo = imgVideo.to_ubytergb
        @imgCam = @inputCam.read_ubytergb
        
        # Calculate movement variables
        diff = @imgCam.to_int - @previous_img
        @previous_img = @imgCam
        @change = MultiArray.tensor( 2 ) { |x,y,u,v| diff.warp( @warpMotion ).to_int[ u, v, x, y ].abs }
        @average = 0.8 * @average + 0.2 * @change
        @area = [ @zone[0].begin / B, @zone[1].begin / B ]
        
        enoughMovement = @change[ *@area ] > THRESHOLD * @average[ *@area ]
        if @successfulAttack == true
          raise 'successful attack'
        end
        # Check if successful attack
        if @successfulAttack == nil and @attack == true
          if Time.new.to_f - @videoStart > @attackTime
            @successfulAttack = false
          end
          if enoughMovement
            @successfulAttack = true
            if @ui.player2PB.value - DAMAGE - @index % 3 * BONUS_DAMAGE > 0
              @ui.player2PB.setValue(@ui.player2PB.value - DAMAGE - @index % 3 * BONUS_DAMAGE)
            else
              @ui.player2PB.setValue(0)
              finishGame "finalWinner"
            end
          end
        end
        
        # Mask to determine if player is present or not
        mask = ( @imgCam.to_sint - @camBg.to_sint ).abs >= PRESENT_THRESHOLD
        
        # Check if successful dodge
        if @successfulDodge == nil and @attack == false
          if Time.new.to_f - @videoStart > @dodgeTime 
            @successfulDodge = false
          end
          if enoughMovement or 100 * mask[ *@zone ].to_ubyte.sum / mask[ *@zone ].size < PLAYER_PRESENT_THRESHOLD
            @successfulDodge = true
          end
        end
        
        # Background extraction
        img = (imgVideo <= 8 ).conditional( @imgCam,  imgVideo)

        # Highlight the attack/dodge area
        if @successfulAttack == nil and @successfulDodge == nil
          img[ *@zone ] = 255 - img[ *@zone ]
        elsif @successfulAttack == true or @successfulDodge == false
          img[ *@zone ] = RGB(255,0,0)
        else
          img[ *@zone ] = RGB(0,0,255)
        end
        # Display final image
        @xvwidget.write img.warp( @warp )
      
      rescue Exception => e
        if @finished
          @picTurn = true
        else
          if @successfulDodge == false
            if @ui.player1PB.value - DAMAGE - @index % 3 * BONUS_DAMAGE > 0
              @ui.player1PB.setValue(@ui.player1PB.value - DAMAGE - @index % 3 * BONUS_DAMAGE)
            else
              @ui.player1PB.setValue(0)
              finishGame "finalLoser"
            end
          end
          if !@finished
            @successfulAttack = nil
            @successfulDodge = nil

            if @index != 0
              @index = 0
            else
              @index = rand(7)
            end
            if @index == 0
              @attack = nil
            else
              @attack = @index > 3 ? true : false
            end
            @zone = @boxes[@index]
            @inputVideo = XineInput.new "Videos/#{@path}/video#{@index}.avi"
            @videoStart = Time.new.to_f
          end
        end
      end
    elsif @picPath != nil
      pictures = %x[ls "#{@picPath}"].split("\n")
      pictures.each{ |pic|
        if pic[3 .. -5] >= @start
          @xvwidget.write MultiArray.load_ubytergb "#{@picPath}" + pic
          sleep(2)
        end
      }
      restart
    end
  end
  
  def settings
    @setting.show
  end
  
  def restart
    @ui.instructionsLbl.setVisible(true)
    @ui.stopBtn.setVisible(false)
    @ui.player1PB.setVisible(false)
    @ui.player2PB.setVisible(false)
    @ui.player1PB.setValue(100)
    @ui.player2PB.setValue(100)
    @ui.timerLbl.setVisible(false)
    @ui.player1Lbl.setVisible(false)
    @ui.player2Lbl.setVisible(false)
    @ui.settingsBtn.setEnabled(true)
    @ui.fightBtn.setEnabled(true)
    @start = nil
    @picTurn = false
    @successfulAttack = nil
    @successfulDodge = nil
    @picPath = nil
    @zone = @boxes[0]
    @attack = nil
  end
  
  def finishGame( video )
    @finished = true
    @successfulAttack = false
    @fightTimer = nil
    @successfulDodge = false
    @attack = nil
    @inputVideo = XineInput.new "Videos/#{@path}/" + video + ".avi"
    @videoStart = Time.new.to_f
  end
  
end
app = Qt::Application.new(ARGV)

camSpace = GUI.new
camSpace.show
app.exec
