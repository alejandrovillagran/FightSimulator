=begin
** Form generated from reading ui file 'settingsGUI.ui'
**
** Created: Fri Apr 29 18:57:15 2011
**      by: Qt User Interface Compiler version 4.6.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Settings
    attr_reader :buttonBox
    attr_reader :timeoutCB
    attr_reader :groupBox
    attr_reader :easyRB
    attr_reader :normalRB
    attr_reader :hardRB
    attr_reader :timeoutSB
    attr_reader :label
    attr_reader :nameLE
    attr_reader :groupBox_2
    attr_reader :alexRB
    attr_reader :janRB
    attr_reader :pathLE
    attr_reader :photosPathCB

    def setupUi(settings)
    if settings.objectName.nil?
        settings.objectName = "settings"
    end
    settings.resize(303, 369)
    @buttonBox = Qt::DialogButtonBox.new(settings)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(70, 320, 171, 32)
    @buttonBox.orientation = Qt::Horizontal
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok
    @timeoutCB = Qt::CheckBox.new(settings)
    @timeoutCB.objectName = "timeoutCB"
    @timeoutCB.geometry = Qt::Rect.new(30, 280, 94, 20)
    @font = Qt::Font.new
    @font.family = "Sans Serif"
    @font.bold = true
    @font.weight = 75
    @timeoutCB.font = @font
    @groupBox = Qt::GroupBox.new(settings)
    @groupBox.objectName = "groupBox"
    @groupBox.geometry = Qt::Rect.new(30, 70, 241, 80)
    @groupBox.font = @font
    @easyRB = Qt::RadioButton.new(@groupBox)
    @easyRB.objectName = "easyRB"
    @easyRB.geometry = Qt::Rect.new(130, 10, 109, 22)
    @font1 = Qt::Font.new
    @font1.bold = false
    @font1.italic = false
    @font1.weight = 50
    @easyRB.font = @font1
    @normalRB = Qt::RadioButton.new(@groupBox)
    @normalRB.objectName = "normalRB"
    @normalRB.geometry = Qt::Rect.new(130, 30, 109, 22)
    @normalRB.font = @font1
    @normalRB.checked = true
    @hardRB = Qt::RadioButton.new(@groupBox)
    @hardRB.objectName = "hardRB"
    @hardRB.geometry = Qt::Rect.new(130, 50, 109, 22)
    @hardRB.font = @font1
    @timeoutSB = Qt::SpinBox.new(settings)
    @timeoutSB.objectName = "timeoutSB"
    @timeoutSB.geometry = Qt::Rect.new(160, 270, 55, 27)
    @timeoutSB.maximum = 999
    @timeoutSB.value = 120
    @label = Qt::Label.new(settings)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(30, 30, 111, 17)
    @label.font = @font
    @nameLE = Qt::LineEdit.new(settings)
    @nameLE.objectName = "nameLE"
    @nameLE.geometry = Qt::Rect.new(160, 20, 113, 27)
    @groupBox_2 = Qt::GroupBox.new(settings)
    @groupBox_2.objectName = "groupBox_2"
    @groupBox_2.geometry = Qt::Rect.new(30, 150, 241, 61)
    @groupBox_2.font = @font
    @alexRB = Qt::RadioButton.new(@groupBox_2)
    @alexRB.objectName = "alexRB"
    @alexRB.geometry = Qt::Rect.new(130, 10, 109, 22)
    @alexRB.font = @font1
    @alexRB.checked = true
    @janRB = Qt::RadioButton.new(@groupBox_2)
    @janRB.objectName = "janRB"
    @janRB.geometry = Qt::Rect.new(130, 30, 109, 22)
    @janRB.font = @font1
    @janRB.checked = false
    @pathLE = Qt::LineEdit.new(settings)
    @pathLE.objectName = "pathLE"
    @pathLE.geometry = Qt::Rect.new(160, 220, 113, 27)
    @photosPathCB = Qt::CheckBox.new(settings)
    @photosPathCB.objectName = "photosPathCB"
    @photosPathCB.geometry = Qt::Rect.new(30, 223, 131, 22)
    @photosPathCB.font = @font
    @photosPathCB.checked = true

    retranslateUi(settings)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), settings, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), settings, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(settings)
    end # setupUi

    def setup_ui(settings)
        setupUi(settings)
    end

    def retranslateUi(settings)
    settings.windowTitle = Qt::Application.translate("settings", "Settings", nil, Qt::Application::UnicodeUTF8)
    @timeoutCB.text = Qt::Application.translate("settings", "Timer", nil, Qt::Application::UnicodeUTF8)
    @groupBox.title = Qt::Application.translate("settings", "Difficulty", nil, Qt::Application::UnicodeUTF8)
    @easyRB.text = Qt::Application.translate("settings", "Easy", nil, Qt::Application::UnicodeUTF8)
    @normalRB.text = Qt::Application.translate("settings", "Normal", nil, Qt::Application::UnicodeUTF8)
    @hardRB.text = Qt::Application.translate("settings", "Hard", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("settings", "Player name:", nil, Qt::Application::UnicodeUTF8)
    @nameLE.text = Qt::Application.translate("settings", "Player 1", nil, Qt::Application::UnicodeUTF8)
    @groupBox_2.title = Qt::Application.translate("settings", "Opponent", nil, Qt::Application::UnicodeUTF8)
    @alexRB.text = Qt::Application.translate("settings", "Alex", nil, Qt::Application::UnicodeUTF8)
    @janRB.text = Qt::Application.translate("settings", "Jan", nil, Qt::Application::UnicodeUTF8)
    @pathLE.text = Qt::Application.translate("settings", "./picFS/", nil, Qt::Application::UnicodeUTF8)
    @photosPathCB.text = Qt::Application.translate("settings", "Photos path", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(settings)
        retranslateUi(settings)
    end

end

module Ui
    class Settings < Ui_Settings
    end
end  # module Ui

