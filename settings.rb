require 'Qt'
require 'ui_settings'

class SETTINGS < Qt::Widget
  slots 'accept()', 'reject()'
  
  def initialize( parent = nil )
    super( parent )
    
    @ui = Ui::Settings.new
    @ui.setupUi self
    
    @difficulty = 1
    @enemyName = "Alex"
    @playerName = "Player 1"
    @path = "./picFS/"
  end
  
  def getTimeout
    @timeout
  end

  def getPlayerName
    @playerName
  end
  
  def getEnemyName
    @enemyName
  end

  def getDifficulty
    @difficulty
  end
  
  def getPath
    @path
  end
  
  def getPicturesOn
    @ui.photosPathCB.checked
  end
  
  def accept
    if @ui.timeoutCB.checked
      @timeout = @ui.timeoutSB.value
    else
      @timeout = nil
    end
    
    @playerName = @ui.nameLE.text
    @path = @ui.pathLE.text
    
    if @ui.alexRB.checked
      @enemyName = "Alex"
    else
      @enemyName = "Jan"
    end
    
    if @ui.easyRB.checked
      @difficulty = 0
    elsif @ui.normalRB.checked
      @difficulty = 1
    else
      @difficulty = 2 
    end
    self.hide
  end
  
  def reject
    self.hide
  end
  
end
