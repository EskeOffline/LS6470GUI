from PySide6.QtCore import QObject, Slot, Signal
import sys
import os
import serial  # Import per ottenere le porte seriali disponibili
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QLibraryInfo
import json
import subprocess
import platform

class Backend(QObject):
    
    def __init__(self, app):
        super().__init__()
        self.miniterm_proc = None  # Traccia il processo miniterm
        app.aboutToQuit.connect(self.chiudiMiniterm)
        

    writeSuccess = Signal()
    overwriteRequested = Signal(str)  

    @Slot()
    def clearLogs(self):  # ELIMINA I LOG (i file vengono ricreati dal programma automaticamente)
        folder = "Log"
        files_to_delete = ["Log.txt"]

        for filename in files_to_delete:
            path = os.path.join(folder, filename)
            try:
                if os.path.exists(path):
                    os.remove(path)
                    print(f"{filename} eliminato.")
            except Exception as e:
                print(f"Errore eliminando {filename}: {e}")

    @Slot(result='QVariantList')
    def getSerialPorts(self):  # Restituisce un elenco delle porte seriali collegate
        ports = serial.tools.list_ports.comports()
        return [port.device for port in ports]  # varia da windows a linux

    def _write(self, text, filename):  # Funzione di scrittura (crea i file nella cartella Log se non esistono)
        folder = "Log"
        os.makedirs(folder, exist_ok=True)
        path = os.path.join(folder, filename)
        try:
            with open(path, "a", encoding="utf-8") as file:
                file.write(text + "\n")
            print(f"{filename} scritto correttamente")
            self.writeSuccess.emit()
        except Exception as e:
            print(f"Errore nella scrittura di {filename}: {e}")
    @Slot()
    def apriMiniterm(self):
        exe_windows = os.path.join(os.path.expanduser("~"), "Documents/L6470GUI", "miniterm.exe")
        exe_linux = os.path.join(os.path.expanduser("~"), "Documents/L6470GUI", "miniterm")
        sistema = platform.system()

        if sistema == "Windows":
            self.miniterm_proc = subprocess.Popen(f'start cmd /c "{exe_windows}"', shell=True)
        elif sistema == "Linux":
            self.miniterm_proc = subprocess.Popen(["gnome-terminal", "--", exe_linux])  # Avvia processo
        else:
            print("Sistema operativo non supportato!")

    def chiudiMiniterm(self):
        #"""Chiude il processo miniterm se è stato avviato"""
        if self.miniterm_proc:
            self.miniterm_proc.terminate()  # Termina il processo
            self.miniterm_proc.wait()  # Attende la chiusura completa
            print("miniterm chiuso correttamente.")

    def __del__(self):
        #"""Assicura la chiusura alla distruzione dell'oggetto"""
        self.chiudiMiniterm()