# Python Calculator

A simple calculator application with a graphical user interface built using Python and Tkinter.

## Features

- Basic arithmetic operations (addition, subtraction, multiplication, division)
- Clean and intuitive user interface
- Error handling for invalid inputs and division by zero
- Standalone executable for Windows

## Requirements

- Python 3.6 or higher
- Tkinter (included with most Python installations)
- PyInstaller (for building the executable)

## Installation

1. Clone or download this repository
2. Create a virtual environment (optional but recommended):
   ```
   python -m venv venv
   venv\Scripts\activate
   ```
3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

## Usage

Run the calculator:

```
python calculator.py
```

## Building the Executable

To create a standalone Windows executable:

1. Ensure you have PyInstaller installed
2. Run the build script:
   ```
   python build.py
   ```
3. The executable will be created in the `dist` folder

## Testing

Run the tests:

```
pytest tests/