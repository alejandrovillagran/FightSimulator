=begin
** Form generated from reading ui file 'mainGUI.ui'
**
** Created: Fri Mar 25 01:17:11 2011
**      by: Qt User Interface Compiler version 4.6.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_SimulatorWindow
    attr_reader :gridLayoutWidget
    attr_reader :gridLayout
    attr_reader :horizontalLayout
    attr_reader :fightBtn
    attr_reader :settingsBtn
    attr_reader :quitBtn
    attr_reader :scrollArea
    attr_reader :scrollAreaWidgetContents
    attr_reader :player1Lbl
    attr_reader :player2Lbl
    attr_reader :timerLbl
    attr_reader :player1PB
    attr_reader :player2PB
    attr_reader :stopBtn
    attr_reader :instructionsLbl

    def setupUi(simulatorWindow)
    if simulatorWindow.objectName.nil?
        simulatorWindow.objectName = "simulatorWindow"
    end
    simulatorWindow.resize(651, 510)
    @gridLayoutWidget = Qt::Widget.new(simulatorWindow)
    @gridLayoutWidget.objectName = "gridLayoutWidget"
    @gridLayoutWidget.geometry = Qt::Rect.new(10, 40, 631, 461)
    @gridLayout = Qt::GridLayout.new(@gridLayoutWidget)
    @gridLayout.objectName = "gridLayout"
    @gridLayout.sizeConstraint = Qt::Layout::SetMaximumSize
    @gridLayout.setContentsMargins(0, 0, 0, 0)
    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.objectName = "horizontalLayout"
    @fightBtn = Qt::PushButton.new(@gridLayoutWidget)
    @fightBtn.objectName = "fightBtn"

    @horizontalLayout.addWidget(@fightBtn)

    @settingsBtn = Qt::PushButton.new(@gridLayoutWidget)
    @settingsBtn.objectName = "settingsBtn"

    @horizontalLayout.addWidget(@settingsBtn)

    @quitBtn = Qt::PushButton.new(@gridLayoutWidget)
    @quitBtn.objectName = "quitBtn"

    @horizontalLayout.addWidget(@quitBtn)


    @gridLayout.addLayout(@horizontalLayout, 1, 0, 1, 1)

    @scrollArea = Qt::ScrollArea.new(@gridLayoutWidget)
    @scrollArea.objectName = "scrollArea"
    @scrollArea.widgetResizable = true
    @scrollAreaWidgetContents = Qt::Widget.new()
    @scrollAreaWidgetContents.objectName = "scrollAreaWidgetContents"
    @scrollAreaWidgetContents.geometry = Qt::Rect.new(0, 0, 627, 422)
    @scrollArea.setWidget(@scrollAreaWidgetContents)

    @gridLayout.addWidget(@scrollArea, 0, 0, 1, 1)

    @player1Lbl = Qt::Label.new(simulatorWindow)
    @player1Lbl.objectName = "player1Lbl"
    @player1Lbl.geometry = Qt::Rect.new(10, 10, 135, 23)
    @font = Qt::Font.new
    @font.family = "Bitstream Charter"
    @font.pointSize = 16
    @font.bold = true
    @font.italic = true
    @font.weight = 75
    @player1Lbl.font = @font
    @player1Lbl.alignment = Qt::AlignCenter
    @player2Lbl = Qt::Label.new(simulatorWindow)
    @player2Lbl.objectName = "player2Lbl"
    @player2Lbl.geometry = Qt::Rect.new(500, 10, 141, 23)
    @player2Lbl.font = @font
    @player2Lbl.styleSheet = "<text-align=\"right\">"
    @player2Lbl.alignment = Qt::AlignCenter
    @timerLbl = Qt::Label.new(simulatorWindow)
    @timerLbl.objectName = "timerLbl"
    @timerLbl.geometry = Qt::Rect.new(300, 10, 41, 23)
    @timerLbl.font = @font
    @timerLbl.alignment = Qt::AlignCenter
    @player1PB = Qt::ProgressBar.new(simulatorWindow)
    @player1PB.objectName = "player1PB"
    @player1PB.enabled = true
    @player1PB.geometry = Qt::Rect.new(150, 10, 118, 23)
    @player1PB.value = 100
    @player1PB.textVisible = true
    @player1PB.invertedAppearance = false
    @player2PB = Qt::ProgressBar.new(simulatorWindow)
    @player2PB.objectName = "player2PB"
    @player2PB.enabled = true
    @player2PB.geometry = Qt::Rect.new(370, 10, 118, 23)
    @player2PB.styleSheet = ""
    @player2PB.value = 100
    @player2PB.textVisible = true
    @player2PB.invertedAppearance = true
    @stopBtn = Qt::PushButton.new(simulatorWindow)
    @stopBtn.objectName = "stopBtn"
    @stopBtn.geometry = Qt::Rect.new(11, 474, 205, 27)
    @instructionsLbl = Qt::Label.new(simulatorWindow)
    @instructionsLbl.objectName = "instructionsLbl"
    @instructionsLbl.geometry = Qt::Rect.new(10, 6, 641, 30)
    @font1 = Qt::Font.new
    @font1.family = "Bitstream Charter"
    @font1.bold = true
    @font1.weight = 75
    @instructionsLbl.font = @font1
    @instructionsLbl.alignment = Qt::AlignCenter

    retranslateUi(simulatorWindow)

    Qt::MetaObject.connectSlotsByName(simulatorWindow)
    end # setupUi

    def setup_ui(simulatorWindow)
        setupUi(simulatorWindow)
    end

    def retranslateUi(simulatorWindow)
    simulatorWindow.windowTitle = Qt::Application.translate("simulatorWindow", "Fight Simulator", nil, Qt::Application::UnicodeUTF8)
    @fightBtn.text = Qt::Application.translate("simulatorWindow", "Fight", nil, Qt::Application::UnicodeUTF8)
    @settingsBtn.text = Qt::Application.translate("simulatorWindow", "Settings", nil, Qt::Application::UnicodeUTF8)
    @quitBtn.text = Qt::Application.translate("simulatorWindow", "Quit", nil, Qt::Application::UnicodeUTF8)
    @player1Lbl.text = ''
    @player2Lbl.text = ''
    @timerLbl.text = ''
    @player1PB.format = Qt::Application.translate("simulatorWindow", "%v", nil, Qt::Application::UnicodeUTF8)
    @player2PB.format = Qt::Application.translate("simulatorWindow", "%v", nil, Qt::Application::UnicodeUTF8)
    @stopBtn.text = Qt::Application.translate("simulatorWindow", "Stop game", nil, Qt::Application::UnicodeUTF8)
    @instructionsLbl.text = Qt::Application.translate("simulatorWindow", "Press 'Fight' button to take a picture of the background and place yourself in the silhouette to fight!", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(simulatorWindow)
        retranslateUi(simulatorWindow)
    end

end

module Ui
    class SimulatorWindow < Ui_SimulatorWindow
    end
end  # module Ui

