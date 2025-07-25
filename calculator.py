import tkinter as tk
from calculator_gui import CalculatorGUI
from calculator_engine import CalculatorEngine

class CalculatorApp:
    """Main calculator application class"""
    
    def __init__(self):
        """Initialize the calculator application"""
        self.root = tk.Tk()
        self.gui = CalculatorGUI(self.root, self.calculate)
    
    def calculate(self, expression):
        """
        Calculate the result of an expression
        
        Args:
            expression (str): The expression to calculate
            
        Returns:
            The result of the calculation
        """
        return CalculatorEngine.calculate(expression)
    
    def run(self):
        """Run the calculator application"""
        self.root.mainloop()

if __name__ == "__main__":
    app = CalculatorApp()
    app.run()