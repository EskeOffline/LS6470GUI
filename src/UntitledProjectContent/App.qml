import QtQuick
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs
import Qt.labs.platform


Window {
    Material.theme: Material.Dark
    Material.accent: "#89D1DA"
    
    id:win
    width: screen.width * 0.8
    height: screen.height * 0.8
    visible: true
    title: "LS6470 CONTROL GUI"

        minimumWidth: 800
        minimumHeight: 800

    onVisibilityChanged: function(visibility) {  //imposta minimo di grandezza della finestra
            if (visibility === Window.FullScreen) {
                // Sblocca limiti
                win.maximumWidth = Number.POSITIVE_INFINITY
                win.maximumHeight = Number.POSITIVE_INFINITY
            } else {
                // Ri-blocca dimensioni
                win.minimumWidth = 800
                win.minimumHeight = 800
            }
        }

    property alias parametriRichiestiApp: screen.parametriRichiesti

    property alias comboboxCMD: screen.combobox0
    property alias textFieldP1: screen.textFieldP1Screen
    property alias textFieldP2: screen.textFieldP2Screen
    property alias textFieldP3: screen.textFieldP3Screen

    property alias radioButtonM0: screen.radioButtonM0
    property alias radioButtonM1: screen.radioButtonM1

    property alias buttonOpenSerial: screen.buttonOpenSerial
    property alias buttonRefreshSerial: screen.buttonRefreshSerial

    property alias comboboxSER: screen.combobox1
    property alias textFieldBaud: screen.textFieldBaud
    property alias textFieldDbits: screen.textFieldDbits
    property alias textFieldSbits: screen.textFieldSBits
    property alias comboboxParity: screen.combobox2
    property alias comboboxFlow: screen.combobox3

    property alias buttonTerm: screen.buttonTerm

    property alias buttonSendGUI: screen.buttonSendGUI
    property alias buttonCloseSer: screen.buttonCloseSer

    property alias checkboxTx: screen.checkBoxTx
    property alias checkboxRx: screen.checkBoxRx

    property alias buttonViewLog: screen.buttonViewLog
    property alias buttonDelLog: screen.buttonDelLogs

    property alias buttonTXT: screen.buttonOpenTXT

    property alias fileDialog:screen.fileDialogTxt

    property alias buttonSendALT: screen.buttonSendALT

    property alias textFieldMXALT: screen.textFieldMXALT
    property alias textFieldCMDALT: screen.textFieldCMDALT
    property alias textFieldP1ALT: screen.textFieldP1ALT
    property alias textFieldP2ALT: screen.textFieldP2ALT
    property alias textFieldP3ALT: screen.textFieldP3ALT

    Screen01 {
        id: screen

        function genMotorChoice(){

            let stringa

            if(radioButtonM0.checked){
                stringa="M0"
            } else if (radioButtonM1.checked){
                stringa="M1"
            } else {

                return "M0"

            }

            return stringa
        }

        function genCMDChoice(){

            return comboboxCMD.currentText


        }

        function param1String(){

        return textFieldP1.text

        }

        function param2String(){

        return textFieldP2.text

        }

        function param3String(){

        return textFieldP3.text

        }


        function genStringaGUI(){  //GENERA LA STRINGA usando solo la GUI

            let stringa
            let nParamStringa

            switch(comboboxCMD.currentIndex){
            case 0:
            nParamStringa=0
            break
            case 1:
            nParamStringa=2
            break
            case 2:
            nParamStringa=1
            break
            case 3:
            nParamStringa=2
            break
            case 4:
            nParamStringa=1
            break
            case 5:
            nParamStringa=2
            break
            case 6:
            nParamStringa=1
            break
            case 7:
            nParamStringa=2
            break
            case 8:
            nParamStringa=3
            break
            case 9:
            nParamStringa=2
            break
            case 10:
            nParamStringa=0
            break
            case 11:
            nParamStringa=0
            break
            case 12:
            nParamStringa=0
            break
            case 13:
            nParamStringa=0
            break
            case 14:
            nParamStringa=0
            break
            case 15:
            nParamStringa=0
            break
            case 16:
            nParamStringa=0
            break
            case 17:
            nParamStringa=0
            break
            case 18:
            nParamStringa=0
            break

        }
            switch(nParamStringa){
            case 0:
                stringa =[genMotorChoice(), genCMDChoice()].join(".")
                break

            case 1:
                stringa =[genMotorChoice(), genCMDChoice(), param1String()].join(".")
                break

            case 2:
                stringa =[genMotorChoice(), genCMDChoice(), param1String(), param2String()].join(".")
                break

            case 3:
                stringa =[genMotorChoice(), genCMDChoice(), param1String(), param2String(), param3String()].join(".")
                break
            }

            console.log(stringa)
            return stringa

        }


        function genStringaALT(){ //genera la stringa dai field alternativi

        let stringaALT

        let motor = textFieldMXALT.text
        let cmd = textFieldCMDALT.text
        let p1 = textFieldP1ALT.text
        let p2 = textFieldP2ALT.text
        let p3 = textFieldP3ALT.text

        if(p1===""){

        stringaALT = [motor, cmd].join(".")

        } else if (p2==="") {

        stringaALT = [motor, cmd, p1].join(".")

        } else if(p3===""){
        
        stringaALT = [motor, cmd, p1, p2].join(".")

        } else {

        stringaALT = [motor, cmd, p1, p2, p3].join(".")

        }

        return stringaALT

        }

        Component.onCompleted: {

        console.log("Indice corrente:", comboboxSER.currentIndex);
        comboboxCMD.currentIndexChanged.connect(function(){   //verifica dei parametri richiesti per oscurare quelli non necessari
            switch (comboboxCMD.currentIndex) {  //di norma parametririchiesti è = 0
                case 0:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 1:
                parametriRichiestiApp = 2
                    textFieldP3.text=""
                break
                case 2:
                parametriRichiestiApp = 1
                    textFieldP3.text=""
                    textFieldP2.text=""
                break
                case 3:
                parametriRichiestiApp = 2
                    textFieldP3.text=""
                break
                case 4:
                parametriRichiestiApp = 1
                    textFieldP3.text=""
                    textFieldP2.text=""
                break
                case 5:
                parametriRichiestiApp = 2
                    textFieldP3.text=""
                break
                case 6:
                parametriRichiestiApp = 1
                    textFieldP3.text=""
                    textFieldP2.text=""
                break
                case 7:
                parametriRichiestiApp = 2
                    textFieldP3.text=""
                break
                case 8:
                parametriRichiestiApp = 3
                break
                case 9:
                parametriRichiestiApp = 2
                    textFieldP3.text=""
                break
                case 10:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 11:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 12:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 13:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 14:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 15:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 16:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 17:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
                case 18:
                parametriRichiestiApp = 0
                    textFieldP1.text=""
                    textFieldP2.text=""
                    textFieldP3.text=""
                break
            }
          }

        )       

            buttonOpenSerial.clicked.connect(function(){

            serial.setPort(comboboxSER.currentText)

            let baud;

            switch(textFieldBaud.text){


                case "1200":
                baud= 1200
                break

                case "2400":
                baud= 2400
                break

                case "4800":
                baud= 4800
                break

                case "9600":
                baud= 9600
                break

                case "19200":
                baud= 19200
                break

                case "38400":
                baud= 38400
                break

                case "57600":
                baud= 57600
                break
                
                case "115200":
                baud= 115200
                break

                case "230400":
                baud= 230400
                break

                default:
                baud= 115200
                break

            }

            serial.setBaud(baud)

            let intParita

                switch(comboboxParity.currentIndex){

                case 0:
                    intParita=0 //NO PARITY
                    break

                case 1:
                    intParita=3 //ODD

                case 2:
                    intParita=2 //EVEN
                    break


                case 4:
                    intParita=5 //MARK
                    break

                case 5:
                    intParita=4 //SPACE
                    break
                default:
                    intParita=0 //piu usato, in caso non sia stato selezionato nessun indice per la parita.
                    break

                }

            serial.setParity(intParita)

            let intDbits

                switch(textFieldDbits.text){

                case "5":
                    intDbits = 5
                    break

                case "6":
                    intDbits=6
                    break

                case "7":
                    intDbits=7
                    break
                case "8":
                    intDbits=8
                    break
                default:
                    intDbits=8 //quello piu usato, in caso venga messo un valore sbagliato
                    break
                }

            serial.setDataBits(intDbits)

            let intSbits

            switch(textFieldSBits.text){
            case "1":
                intSbits = 1
                break

            case "1.5":
                intSbits=3
                break

            case "2":
                intSbits=2
                break

            default:
                intSbits=1 //quello piu usato, in caso venga inserito un valore errato
                break
            }

            serial.setStopBits(intSbits)
            let intFlow

            switch(comboboxFlow.currentIndex){
            case 0:
                intFlow=0 //NO FLOW CONTROL
                break

            case 1:
                intFlow=2 //HARDWARE
                break

            case 2:
                intFlow=1 //SOFTWARE
                break
            case 3:
                intFlow=0 // DTR/RTS
                break
            default:
                intFlow=1 //hardware XONXOFF defualt
                break
            }

            serial.setFlowControl(intFlow)


            serial.openSerial()

            if(serial.isSerialOpen()){
                console.log("Porta Aperta")
            } else {
                console.log("Errore nell'apertura della porta")
            }
            
            if(comboboxFlow.currentIndex===3){
                let setter = "True"
                serial.setDTR(setter)
                serial.setRTS(setter)
            }

            }

            )


            buttonCloseSer.onClicked.connect(function(){
                serial.shutdownSerial()
                console.log("Porta chiusa")
            })


            buttonSendGUI.onClicked.connect(function(){

                if(serial.isSerialOpen()){

                serial.sendData(genStringaGUI())
                } else {
                console.log("Porta NON aperta")
                }

                if(checkBoxTx.checked){
                    serialLogger.logInvio(genStringaGUI())
                }

            })


            buttonRefreshSerial.onClicked.connect(function(){
            serial.refreshPorts()
            comboboxSER.model=serialModel

            })

            comboboxSER.currentIndexChanged.connect(function(){
                comboboxSER.displayText = comboboxSER.model[comboboxSER.currentIndex]

            }) 
                
            checkBoxRx.onCheckedChanged.connect(function(){
                checkboxRx.checked ? serial.readLoop(1) : serial.readLoop(0); 

            })          
            
            buttonViewLog.onClicked.connect(function(){

                serialLogger.openFolder()



            })

            buttonDelLog.onClicked.connect(function(){

                
            serialLogger.deleteLogs()


            })


            buttonTXT.onClicked.connect(function(){
        
            fileDialog.open()

            })


            buttonSendALT.onClicked.connect(function(){
            
            if(serial.isSerialOpen()){

                serial.sendData(genStringaALT())
                } else {
                console.log("Porta NON aperta")
                }

                if(checkBoxTx.checked){
                    serialLogger.logInvio(genStringaALT())
                }


            })

            buttonTerm.onClicked.connect(function(){

                backend.apriMiniterm()


            })

            

        //FINE SPAZIO PER FUNZIONI
        }


    }
}