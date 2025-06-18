from PySide6.QtCore import QObject, Signal, Slot, QIODevice, QStringListModel
from PySide6.QtSerialPort import QSerialPort
import subprocess
import serial.tools.miniterm
import serial.tools.list_ports as list_ports
from serial_reader import SerialReader
from PySide6.QtWidgets import QFileDialog
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from log_backend import SerialLogger
import time

class SerialManager(QObject):
    app_instance = None
    portsUpdated = Signal(list)  # Segnale per aggiornare QML 

    logger = SerialLogger() 

    def __init__(self):
        super().__init__()
        self.serial = QSerialPort()
        self._port = ""
        self._baud = QSerialPort.Baud115200
        self._parity = QSerialPort.NoParity
        self._dataBits = QSerialPort.Data8
        self._stopBits = QSerialPort.OneStop
        self._flowControl = QSerialPort.NoFlowControl
        self._running = False

        ports = [port.device for port in list_ports.comports()]
        self.model = QStringListModel(ports)
  
    def setApplication(app):
        global app_instance
        app_instance = app  # Memorizza l'istanza di QApplication

    @Slot(str)
    def setPort(self, port_name):
        self._port = port_name

    @Slot(int)
    def setBaud(self, baud):
        self._baud = QSerialPort.BaudRate(baud)

    @Slot(int)
    def setParity(self, parity_value):
        self._parity = QSerialPort.Parity(parity_value)

    @Slot(int)
    def setDataBits(self, data_bits):
        self._dataBits = QSerialPort.DataBits(data_bits)

    @Slot(int)
    def setStopBits(self, stop_bits):
       self._stopBits = QSerialPort.StopBits(stop_bits)

    @Slot(int)
    def setFlowControl(self, flow):
        self._flowControl = QSerialPort.FlowControl(flow)

    @Slot()
    def openSerial(self):
        self.serial.setPortName(self._port)
        self.serial.setBaudRate(self._baud)
        self.serial.setParity(self._parity)
        self.serial.setDataBits(self._dataBits)
        self.serial.setStopBits(self._stopBits)
        self.serial.setFlowControl(self._flowControl)
        if not self.serial.open(QIODevice.ReadWrite):  # Apre la porta
            print(f"Errore: Impossibile aprire la porta seriale {self._port}.")

    @Slot()
    def shutdownSerial(self):
        if self.serial.isOpen():
            self.serial.setDataTerminalReady(False)
            self.serial.setRequestToSend(False)
            self.serial.close()

    @Slot(bool)
    def setDTR(self, enable: bool):
        if self.serial.isOpen():
            self.serial.setDataTerminalReady(enable)

    @Slot(bool)
    def setRTS(self, enable: bool):
        if self.serial.isOpen():
            self.serial.setRequestToSend(enable)

    @Slot(result=bool)
    def isSerialOpen(self):
        return self.serial.isOpen()
    
    @Slot(str, int)
    def apriMiniTerm(self, porta, baud):
        try:
            command = f'python -m serial.tools.miniterm {porta} {baud}'
            subprocess.Popen(["cmd", "/k", command])  # "/k" mantiene la finestra aperta
        except Exception as e:
            print(f"Errore: {e}")

    @Slot(str)
    def sendData(self, data):
        app = str(data)
        hex="0D"
        if self.serial.isOpen():
            self.serial.flush()
            print("dati inviati: " + app)
            self.serial.write(app.encode()) # Codifica la stringa in bit e la invia
            self.serial.flush() 
            self.serial.write(bytes.fromhex(hex))   #0D hex per far funzionare la corretta lettura della stringa
            self.serial.flush()
            
        else:
            print("Errore: La porta seriale non è aperta.")

    @Slot(str)
    def sendDataFromTXT(self, data):
        if self.serial.isOpen():
            self.serial.flush()
            print("dati inviati: " + data)
            self.serial.write(data.encode()) # Codifica la stringa in bit e la invia
            self.serial.flush() 
            
        else:
            print("Errore: La porta seriale non è aperta.")

    @Slot(int)
    def readLoop(self, do : int):
        if do==1:
            self.reader = SerialReader(self.serial)  # Crea un'istanza
            self.reader.start()  # Avvia il thread
        else:
            if hasattr(self, "reader"):  # Controlla se esiste l'istanza
                self.reader.stop()  # Ferma il loop
                

    @Slot()
    def readSerialData(self):
        if self.serial.isOpen():
            data = self.serial.readAll()
        if not data.isEmpty():  # Assicura che i dati siano presenti
            return data.decode('utf-8')
        else:
            print("Nessun dato ricevuto")
    @Slot()
    def refreshPorts(self):
        ports = [str(port.device) for port in serial.tools.list_ports.comports()]
        print("🔹 Tipo di ports:", type(ports))  # ✅ Debug del tipo di dato
        print("🔹 Contenuto di ports:", ports)  # ✅ Stampa i dati reali
        self.model.setStringList(QStringListModel(ports).stringList())  # ✅ Conversione corretta in QStringList
        print("Modello aggiornato:", self.model.stringList())
    
    @Slot(result=list)
    def getPorts(self):
        return self.model.stringList()
    
    @Slot(result=list)
    def getModel(self):
        ports = [str(port.device) for port in serial.tools.list_ports.comports()]


    @Slot(str)
    def openFileTXT(self, file_path):

        hex = bytes.fromhex("0D")
        print(f"Percorso file ricevuto: {file_path}") 

        if file_path.startswith("file:///"):
            file_path = file_path[8:]
        elif file_path.startswith("file:/"):
            file_path = file_path[6:]

        path = Path(file_path)

        if path.exists():
            try:
                with path.open("r", encoding="utf-8") as file:
                    while True:
                        #self.serial.clear()  # Pulizia buffer prima di ogni invio

                        line = file.readline()  # Legge una riga alla volta
                        print(f"Riga grezza letta: {repr(line)}")
                        if not line:  # Se la riga è vuota, interrompe il ciclo
                            break
                        comando_pulito = line.strip().replace("\n", "").replace("\r", "")  # Pulizia della stringa
                        if comando_pulito: 
                            print(f"Dati puliti da inviare: {repr(comando_pulito)}")

                            if self.serial.isOpen():
                                print(f"Dati inviati: {repr(comando_pulito.encode())}")
                                self.serial.clear()
                                self.sendDataFromTXT(comando_pulito)  # Invia il comando pulito
                                self.serial.flush()
                                time.sleep(0.05)  # Breve pausa

                                self.serial.write(hex)  # Invia 0D separatamente
                                if not self.serial.waitForBytesWritten(100):  # attende 100ms (puoi aumentare se necessario)
                                    print("Timeout nell'attesa della scrittura del terminatore 0D")
                                self.serial.flush()
                                time.sleep(1)  # Pausa tra invii per evitare problemi di buffer

                        


                        else:
                            print("Riga vuota, nessun invio sulla seriale")
            except Exception as e:
                print(f"Errore nella lettura del file: {e}")
        else:
            print(f"Errore: Il file non esiste -> {file_path}")
            
            
            
            
            
            
            
