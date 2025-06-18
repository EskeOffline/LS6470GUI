from cx_Freeze import setup, Executable
import os

current=os.getcwd()
options = {
    "build_exe": {
        "packages": ["PySide6", "shiboken6", "Backend.Serial"],
        "include_files": [
            ("UntitledProjectContent", "UntitledProjectContent")  # Assicura che venga copiato
        ]
    }
}


setup(
    name="L6470 CONTROL GUI",
    version="1.0",
    description="L6470 Control with included GUI and implemented TXT file read for strings to send via serial, terminal via serial and string generation for L6470 units",
    executables=[Executable("main.py", base="Win32GUI", icon="exe_icon.ico")]
)