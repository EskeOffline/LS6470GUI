@echo off
echo Installazione dei moduli Python necessari...

:: Assicura di avere pip aggiornato
python -m pip install --upgrade pip

:: Installa i moduli richiesti
pip install PySide6
pip install pyserial
pip install cx_Freeze
pip install pyinstaller

echo Installazione completata!
pause