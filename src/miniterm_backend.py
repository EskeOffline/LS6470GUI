import serial
import threading
from PySide6.QtCore import QObject, Signal, Slot
import serial.tools.miniterm
from PySide6.QtCore import qDebug

class MiniTermManager(QObject):

    dataReceived = Signal(str, arguments=['msg'])

    def __init__(self):
        super().__init__()
        self.ser = None
        self._running = False

    @Slot(str, int)
    def start(self, port, baudrate):
        try:
            self.ser = serial.Serial(port, baudrate, timeout=0.1)
            self._running = True
            threading.Thread(target=self._read_loop, daemon=True).start()
            print(f"Miniterm avviato su {port} @ {baudrate}")
        except Exception as e:
            print(f" Errore avvio: {e}")

    def _read_loop(self):
        print("[THREAD] Attivo")
        while self._running and self.ser and self.ser.is_open:
            try:
                raw = self.ser.read(1024)
                data = raw.decode(errors='ignore').strip()
                if data:
                    self.dataReceived.emit(data)
            except Exception as e:
                print("[ERRORE LETTURA]:", e)

    @Slot(str)
    def send(self, text):
        if self.ser is None or not self.ser.is_open:
            qDebug("Errore: La porta seriale non è aperta o non è stata inizializzata")

        if self.ser and self.ser.is_open:
            self.ser.write((text + '\n').encode())

    @Slot()
    def stop(self):
        self._running = False
        if self.ser and self.ser.is_open:
            self.ser.close()
            print("Connessione chiusa")

    @Slot()
    def test_emit(self):
        self.dataReceived.emit("Messaggio di test")