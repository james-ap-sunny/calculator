import PyInstaller.__main__
import os
import sys

def build_executable():
    """Build the calculator executable"""
    print("Building Calculator executable...")
    
    # Define PyInstaller command
    PyInstaller.__main__.run([
        'calculator.py',
        '--onefile',
        '--windowed',
        '--name=Calculator',
        '--icon=calculator_icon.ico' if os.path.exists('calculator_icon.ico') else None,
        '--clean',
        '--add-data=calculator_engine.py;.',
        '--add-data=calculator_gui.py;.'
    ])
    
    print("Build completed successfully!")
    print("Executable can be found in the 'dist' folder.")

if __name__ == "__main__":
    build_executable()