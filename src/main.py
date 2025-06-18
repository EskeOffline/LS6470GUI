import sys
import os
from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QLibraryInfo, QObject, QStringListModel, QUrl, Slot, Signal
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from backend import Backend
from backend_serial import SerialManager
import serial.tools.list_ports as list_ports
from miniterm_backend import MiniTermManager
from log_backend import SerialLogger
import resources
from serial_reader import SerialReader
from PySide6.QtGui import QIcon




if __name__ == "__main__":
    # App & engine
    app = QGuiApplication(sys.argv)
    app.setWindowIcon(QIcon("UntitledProjectContent/images/icon.png"))
    engine = QQmlApplicationEngine()
    SerialManager.setApplication(app)

    # Ambiente Qt
    os.environ["QT_QPA_PLATFORM_PLUGIN_PATH"] = QLibraryInfo.path(QLibraryInfo.PluginsPath)
    os.environ["QML2_IMPORT_PATH"] = QLibraryInfo.path(QLibraryInfo.Qml2ImportsPath)

    # Percorso contenuto QML

    qml_path = os.path.join(os.path.dirname(__file__), '..', 'UntitledProjectContent')
    engine.addImportPath(qml_path)

    serial = SerialManager()
    engine.rootContext().setContextProperty("serial", serial) #gestisce il resto della logica delle seriali
    engine.rootContext().setContextProperty("serialModel", serial.model)

    miniterm = MiniTermManager()
    engine.rootContext().setContextProperty("miniterm", miniterm)

    serial_logger = SerialLogger()
    engine.rootContext().setContextProperty("serialLogger", serial_logger)

    backend = Backend(app)
    engine.rootContext().setContextProperty("backend", backend)

    # Registra tipo C++
    qmlRegisterType(SerialManager, "Backend.Serial", 1, 0, "SerialManager")
    qmlRegisterType(MiniTermManager, "Backend.Miniterm", 1, 0, "MiniTermManager")

    # ⬇Carica App.qml
    if getattr(sys, 'frozen', False):
        base_path = os.path.dirname(sys.executable)  # Ottieni la cartella dell'eseguibile
    else:
        base_path = os.path.dirname(__file__)  # Usa la directory dello script

    qml_path = os.path.join(base_path, "UntitledProjectContent", "App.qml")
    engine.load(qml_path)

    if not engine.rootObjects():
        sys.exit(-1)

    # Main loop Qt
    sys.exit(app.exec())