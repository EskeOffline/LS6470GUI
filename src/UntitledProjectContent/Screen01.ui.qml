import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs 6.2

Rectangle {
    id: rectangle
    width: 800
    height: 800
    color: "#218691"
    transformOrigin: Item.Center

    Rectangle {
        id: rectangle2
        x: 395
        y: 493
        width: 1200
        height: 1000
        color: "#1b828d"
        scale: 1.5
        rotation: 318.943
    }

    RadioButton {
        id: radioButton1
        x: 25
        y: 143
        text: qsTr("MOTOR 1")
        icon.color: "#008bff"
    }

    RadioButton {
        id: radioButton
        x: 25
        y: 100
        text: qsTr("MOTOR 0")
        font.letterSpacing: 0
        font.styleName: "Regular"
        font.weight: Font.Light
        font.family: "Arial"
        icon.color: "#008bff"
    }

    Text {
        id: text2
        x: 27
        y: 62
        width: 213
        height: 63
        color: "#ffffff"
        text: qsTr("Seleziona il motore")
        font.pixelSize: 21
        font.styleName: "Bold"
    }

    Rectangle {
        id: rectangle3
        x: 11
        y: 57
        width: 244
        height: 134
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2
    }

    Text {
        id: text3
        x: 25
        y: 211
        width: 234
        height: 37
        color: "#ffffff"
        text: qsTr("Seleziona il comando")
        font.pixelSize: 20
        font.styleName: "Bold"
    }

    Rectangle {
        id: rectangle4
        x: 11
        y: 197
        width: 244
        height: 134
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2

        MyComboBox {
            id: comboBox //COMBOBOX COMANDI
            x: 14
            y: 73
            editable: true
            font.family: "Arial"
            font.capitalization: Font.AllUppercase
            model: ["NOP", "SETPARAM", "GETPARAM", "RUN", "STEPCLOCK", "MOVE", "GOTO", "GOTO_DIR", "GOUNTIL", "RELEASESW", "GOHOME", "GOMARK", "RESETPOS", "RESETDEVICE", "SOFTSTOP", "HARDSTOP", "SOFTHIZ", "HARDHIZ", "GETSTATUS"]
        }

        MyComboBox {
            id: comboBox1 //COMBOBOX PORTE SERIALI
            x: 8
            textRole: "display"
            y: 224
            width: 193
            height: 44
            font.family: "Arial"
            font.capitalization: Font.AllUppercase
            editable: true
            model:serialModel
        }
    
           
        Rectangle {
            id: rectangle7
            x: 244
            y: 65
            width: 37
            height: 2
            color: "#4fffffff"
        }

        MyComboBox {
            id: comboBox2
            x: 422
            y: 224
            width: 193
            height: 44
            model: ["None", "Odd", "Even", "Mark", "Space"]
            font.family: "Arial"
            font.capitalization: Font.AllUppercase
            editable: true
            currentIndex: 0
        }

        MyComboBox {
            id: comboBox3
            x: 422
            y: 302
            width: 193
            height: 44
            model: ["None", "XON/XOFF", "RTS/CTS", "DSR/DTR"]
            font.family: "Arial"
            font.capitalization: Font.AllUppercase
            editable: true
            currentIndex: 1
        }
    }
    Rectangle {
        id: rectangle5
        x: 292
        y: 197
        width: 493
        height: 134
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2
    }

    Text {
        id: text4
        x: 305
        y: 212
        width: 234
        height: 36
        color: "#ffffff"
        text: qsTr("Parametri")
        font.pixelSize: 20
        font.styleName: "Bold"

        TextField {
            readOnly: parametriRichiesti < 1
            id: textField0
            x: 16
            y: 50
            width: 138
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("P1")
        }

        TextField {
            readOnly: parametriRichiesti < 2
            id: textField1
            x: 172
            y: 50
            width: 138
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("P2")
        }

        TextField {
            readOnly: parametriRichiesti < 3
            id: textField2
            x: 328
            y: 50
            width: 138
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("P3")
        }

        TextField {
            id: textField3
            x: -286
            y: 287
            width: 193
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            text: "115200"
            placeholderText: qsTr("....")
            validator: IntValidator {
                bottom: 0
            }
        }

        TextField {
            id: textField4
            x: -63
            y: 209
            width: 138
            height: 45
            validator: IntValidator {
                bottom: 0
            }
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("....")
            text: "8"
        }

        TextField {
            id: textField5
            x: -63
            y: 286
            width: 138
            height: 47
            validator: IntValidator {
                bottom: 0
            }
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("....")
            text: "1"
        }

        TextField {
            id: textField6
            x: 14
            y: 423
            width: 62
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("MX")
        }

        TextField {
            id: textField7
            x: 82
            y: 423
            width: 91
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("CMD")
        }

        TextField {
            id: textField8
            x: 179
            y: 423
            width: 74
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("P1")
        }

        TextField {
            id: textField9
            x: 259
            y: 423
            width: 78
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("P2")
        }

        TextField {
            id: textField10
            x: 343
            y: 423
            width: 78
            height: 47
            selectionColor: "#006bff"
            placeholderTextColor: "#60ffffff"
            placeholderText: qsTr("P3")
        }

    }

    Rectangle {
        id: rectangle6
        x: 8
        y: 337
        width: 776
        height: 225
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2
    }

    Text {
        id: text5
        x: 16
        y: 358
        width: 269
        height: 63
        color: "#ffffff"
        text: qsTr("Impostazioni porta seriale")
        font.pixelSize: 21
        font.styleName: "Bold"
    }

    Text {
        id: text6
        x: 17
        y: 393
        width: 86
        height: 28
        color: "#ffffff"
        text: qsTr("Porta")
        font.pixelSize: 16
        font.styleName: "Bold"
    }

    Text {
        id: text7
        x: 17
        y: 472
        width: 86
        height: 28
        color: "#ffffff"
        text: qsTr("Bitrate (baud)")
        font.pixelSize: 16
        font.styleName: "Bold"
    }

    Text {
        id: text8
        x: 237
        y: 393
        width: 86
        height: 28
        color: "#ffffff"
        text: qsTr("Data Bits")
        font.pixelSize: 16
        font.styleName: "Bold"
    }

    Text {
        id: text9
        x: 237
        y: 472
        width: 86
        height: 28
        color: "#ffffff"
        text: qsTr("Stop Bits")
        font.pixelSize: 16
        font.styleName: "Bold"
    }

    Text {
        id: text10
        x: 432
        y: 393
        width: 86
        height: 28
        color: "#ffffff"
        text: qsTr("Parity")
        font.pixelSize: 16
        font.styleName: "Bold"
    }

    Text {
        id: text11
        x: 432
        y: 472
        width: 86
        height: 28
        color: "#ffffff"
        text: qsTr("Flow Control")
        font.pixelSize: 16
        font.styleName: "Bold"
    }

    Rectangle {
        id: rectangle8
        x: 292
        y: 57
        width: 493
        height: 134
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2
    }

    Text {
        id: text14
        x: 305
        y: 62
        width: 213
        height: 44
        color: "#ffffff"
        text: qsTr("Opzioni Log")
        font.pixelSize: 21
        font.styleName: "Bold"

        CheckBox {
            id: checkBox6
            x: -6
            y: 38
            width: 203
            height: 44
            text: qsTr("Salva dati inviati in un log")
        }

        CheckBox {
            id: checkBox7
            x: -6
            y: 71
            width: 219
            height: 44
            text: qsTr("Salva dati ricevuti in un log")
        }
    }

    Rectangle {
        id: rectangle9
        x: 11
        y: 620
        width: 244
        height: 118
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2
    }

    Button {
        id: button1
        x: 18
        y: 698
        width: 232
        height: 29
        opacity: 1
        text: qsTr("Lancia Terminale")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 9
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Button {
        id: button2
        x: 539
        y: 110
        width: 232
        height: 29
        opacity: 1
        text: qsTr("Visualizza log")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 9
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Button {
        id: button3
        x: 539
        y: 143
        width: 232
        height: 29
        opacity: 1
        text: qsTr("Elimina tutti i log")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 9
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Rectangle {
        id: rectangle10
        x: 261
        y: 620
        width: 526
        height: 118
        color: "#00ffffff"
        border.color: "#4bffffff"
        border.width: 2
    }

    Button {
        id: button4
        x: 322
        y: 693
        width: 401
        height: 40
        opacity: 1
        text: qsTr("Invia")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 23
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Rectangle {
        id: rectangle11
        x: 1411
        y: 474
        width: 1200
        height: 1000
        color: "#1b828d"
        scale: 1.5
        rotation: 318.943
    }

    Rectangle {
        id: rectangle12
        x: 1433
        y: -290
        width: 1200
        height: 1000
        color: "#1b828d"
        scale: 1.5
        rotation: 318.943
    }

    Rectangle {
        id: rectangle13
        x: 1002
        y: 1270
        width: 1200
        height: 1000
        color: "#1b828d"
        scale: 1.5
        rotation: 318.943
    }

    Rectangle {
        id: rectangle14
        x: 0
        y: 0
        width: 2021
        height: 42
        color: "#141748"
    }

    Text {
        id: text12
        x: 8
        y: 8
        width: 784
        height: 42
        color: "#ffffff"
        text: qsTr("L6470 CONTROL GUI")
        font.pixelSize: 24
        font.weight: Font.DemiBold
        font.family: "Arial"
        font.bold: true
    }

    Button {
        id: button5
        x: 10
        y: 568
        width: 384
        height: 39
        opacity: 1
        text: qsTr("Apri collegamento")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 23
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Rectangle {
        id: rectangle15
        x: 1100
        y: 323
        width: 1200
        height: 1000
        color: "#1b828d"
        scale: 1.5
        rotation: -0.025
    }

    Button {
        id: button6
        x: 400
        y: 568
        width: 384
        height: 39
        opacity: 1
        text: qsTr("Invia Dati")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 23
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Button {
        id: button7
        x: 643
        y: 505
        width: 128
        height: 41
        opacity: 1
        text: qsTr("Chiudi Porta")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 9
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Rectangle {
        id: rectangle1
        x: 800
        y: 42
        width: 200
        height: 200
        color: "#1b828d"

    }

    Button {
        id: button8
        x: 18
        y: 670
        width: 232
        height: 29
        opacity: 1
        text: qsTr("Apri file .TXT")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 9
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    Text {
        id: text15
        x: 27
        y: 628
        width: 213
        height: 44
        color: "#ffffff"
        text: qsTr("Misc")
        font.pixelSize: 21
        font.styleName: "Bold"
    }

    Button {
        id: button9
        x: 643
        y: 422
        width: 128
        height: 41
        opacity: 1
        text: qsTr("Aggiorna porte")
        topInset: 0
        icon.color: "#ffffff"
        font.pointSize: 9
        font.family: "Arial"
        font.bold: true
        flat: true
        bottomInset: 0
    }

    FileDialog {
    id: fileDialog
    title: "Seleziona un file..."
    nameFilters: ["Text Files (*.txt)", "All Files (*)"]
        onAccepted: {

            serial.openFileTXT(fileDialog.currentFile)
        }
    }

    states: [
        State {
            name: "clicked"
        }
    ]

    property int parametriRichiesti: 0
    property alias combobox0: comboBox //combobox del Comandi
    property alias combobox1: comboBox1 //combobox porte seiali
    property alias combobox2: comboBox2 //combobox di parità e di flowcontrol
    property alias combobox3: comboBox3

    property alias textFieldBaud: textField3
    property alias textFieldDbits: textField4
    property alias textFieldSBits: textField5

    property alias textFieldP1Screen: textField0 //P1
    property alias textFieldP2Screen: textField1 //P2
    property alias textFieldP3Screen: textField2 //P3

    property alias radioButtonM0: radioButton //Bottone Motor0 e Motor1
    property alias radioButtonM1: radioButton1

    property alias buttonOpenSerial: button5 //bottone apertura porta seriale
    property alias buttonRefreshSerial: button9 //bottone per aggiornare le seriali

    property alias buttonTerm: button1 //bottone di avvio terminale

    property alias buttonSendGUI: button6 //bottone invio dati attrverso la porta seriale

    property alias buttonCloseSer: button7 //bottone per chiudere la porta seriale

    property alias checkBoxTx: checkBox6 //checkbox per log in invio (tx) e ricezione (Rx)
    property alias checkBoxRx: checkBox7

    property alias buttonViewLog : button2 //opzioni log (view and delete)
    property alias buttonDelLogs: button3

    property alias buttonOpenTXT: button8 //apri un file TXT
    property alias fileDialogTxt:fileDialog //dialogo apertura TXT

    property alias buttonSendALT: button4 //button per inviare dal basso (dai parametri)
    property alias textFieldMXALT: textField6 //invio stringa alternativa
    property alias textFieldCMDALT: textField7
    property alias textFieldP1ALT: textField8
    property alias textFieldP2ALT: textField9
    property alias textFieldP3ALT: textField10
}
