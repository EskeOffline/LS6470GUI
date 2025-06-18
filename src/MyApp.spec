from PyInstaller.utils.hooks import collect_data_files

# -*- mode: python ; coding: utf-8 -*-

# Inizializza datas
datas = []
	
datas += collect_data_files('PySide6')
binaries = collect_data_files('PySide6', subdir='lib')  # Aggiunge le DLL Qt

a = Analysis(
    ['main.py'],
    pathex=[],
    binaries=[],
    datas=[('C:/Users/piero/Documents/UntitledProject/Python/UntitledProjectContent', 'qml')],
hiddenimports = [
    # Moduli PySide6 (Qt)
    'PySide6.QtCore',
    'PySide6.QtGui',
    'PySide6.QtWidgets',
    'PySide6.QtQml',
    'PySide6.QtQuick',
    'PySide6.QtQuickControls2',
    'PySide6.QtQuickDialogs',
    'PySide6.QtSerialPort',
    'PySide6.QtLabs.Platform',

    # Moduli Python standard
    'os',
    'sys',
    'glob',
    'subprocess',
    'time',
    'pathlib',
    'threading',

    # Librerie per gestione della porta seriale
    'serial',
    'serial.tools.miniterm',
    'serial.tools.list_ports',

    # Moduli personalizzati
    'serial_reader',
    'log_backend',
    'backend',
    'backend_serial',
    'miniterm_backend',
    'resources',
],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='L6470GUI_Unfinished',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)