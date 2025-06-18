from PySide6.QtCore import QObject, Slot
import os
import glob
from pathlib import Path

class SerialLogger(QObject):
    def __init__(self):
        super().__init__()
        self.log_invio_path = os.path.join(os.path.expanduser("~"), "Documents/L6470GUI/LOGS", "log_invio.txt")
        self.log_ricezione_path = os.path.join(os.path.expanduser("~"), "Documents/L6470GUI/LOGS", "log_ricezione.txt")
        self.logdir = os.path.join(os.path.expanduser("~"), "Documents/L6470GUI/LOGS")

    @Slot(str)
    def logInvio(self, data):
        log_dir = os.path.dirname(self.log_invio_path)
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)  # Crea la cartella
        try:
            with open(self.log_invio_path, "a") as file:
                file.write(data + "\n")
        except FileNotFoundError:
            print("🔹 File non trovato, lo creo ora...")
            with open(self.log_invio_path, "w") as file:  # "w" lo crea se necessario
                file.write(data + "\n")
        except Exception as e:
            print(f"Errore scrittura file in invio: {e}")

    def logRicezione(self, rxData):
        log_dir = os.path.dirname(self.log_ricezione_path)
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)  # Crea la cartella
        try:
            with open(self.log_ricezione_path, "a") as file:  # "a" crea il file se non esiste
                file.write(rxData.toStdString())
        except FileNotFoundError:
            print("🔹 File non trovato, lo creo ora...")
            with open(self.log_ricezione_path, "w") as file:  # "w" lo crea se necessario
                file.write(rxData.toStdString())
        except Exception as e:
            print(f"Errore scrittura file ricezione: {e}")

    @Slot()
    def openFolder(self):
        path=self.logdir
        try:
            if not os.path.exists(path):
                os.makedirs(path)  # Crea la cartella
            if os.name == 'nt':  # For Windows
                os.startfile(path)
            elif os.name == 'posix':  # For macOS/Linux
                os.system(f'open "{path}"' if 'darwin' in os.uname().sysname.lower() else f'xdg-open "{path}"')
        except Exception as e:
            print(f"Error: {e}")



    @Slot()
    def deleteLogs(self):
        path = self.Path(self.logdir)
    
        for file in path.glob("*.txt"):  # Cerca tutti i file .txt
            try:
                file.unlink()  # Cancella il file
                print(f"Eliminato: {file}")
            except Exception as e:
                print(f"Errore eliminando {file}: {e}")
        