from PySide6.QtCore import QThread, Signal
from log_backend import SerialLogger

class SerialReader(QThread):
    data_received = Signal(str)
    logger = SerialLogger()
    def __init__(self, serial):
        super().__init__()
        self.serial = serial
        self.running = False  # Variabile di controllo

    def run(self):
        logger = SerialLogger()
        self.running = True
        data = None
        while self.running:
            data = None
            if self.serial.isOpen():  # Aspetta fino a 1 secondo
                data = self.serial.readAll()    
            if (data!=None and data!=''):
                print(data)
                logger.logRicezione(rxData=data)  

    def stop(self):
        self.running = False