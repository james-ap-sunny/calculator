import tkinter as tk
from tkinter import font

class CalculatorGUI:
    """Handles the GUI components of the calculator"""
    
    def __init__(self, master, calculate_callback):
        """
        Initialize the calculator GUI
        
        Args:
            master: The tkinter root window
            calculate_callback: Function to call when calculation is needed
        """
        self.master = master
        self.calculate_callback = calculate_callback
        self.current_expression = ""
        
        # Configure the main window
        master.title("Calculator")
        master.geometry("300x400")
        master.resizable(False, False)
        master.configure(bg="#f0f0f0")
        
        # Create custom fonts
        self.display_font = font.Font(family="Arial", size=24, weight="bold")
        self.button_font = font.Font(family="Arial", size=12)
        
        # Create the display
        self.create_display()
        
        # Create the buttons
        self.create_buttons()
    
    def create_display(self):
        """Create the calculator display area"""
        # Frame for the display
        display_frame = tk.Frame(self.master, bg="#f0f0f0", height=50)
        display_frame.pack(fill=tk.X, padx=10, pady=10)
        
        # Display label
        self.display = tk.Label(
            display_frame,
            text="0",
            font=self.display_font,
            bg="white",
            fg="black",
            anchor="e",
            relief=tk.SUNKEN,
            bd=2
        )
        self.display.pack(fill=tk.BOTH, expand=True)
    
    def create_buttons(self):
        """Create all calculator buttons"""
        # Frame for the buttons
        buttons_frame = tk.Frame(self.master, bg="#f0f0f0")
        buttons_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Button layout
        button_layout = [
            ["C", "(", ")", "÷"],
            ["7", "8", "9", "×"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "+"],
            ["0", ".", "="]
        ]
        
        # Create buttons according to layout
        for i, row in enumerate(button_layout):
            buttons_frame.grid_rowconfigure(i, weight=1)
            for j, button_text in enumerate(row):
                buttons_frame.grid_columnconfigure(j, weight=1)
                
                # Special styling for different button types
                if button_text == "=":
                    # Equals button spans two columns
                    button = tk.Button(
                        buttons_frame,
                        text=button_text,
                        font=self.button_font,
                        bg="#4CAF50",  # Green
                        fg="white",
                        relief=tk.RAISED,
                        bd=3
                    )
                    button.grid(row=i, column=j, columnspan=2, sticky="nsew", padx=2, pady=2)
                elif button_text in "+-×÷":
                    # Operation buttons
                    button = tk.Button(
                        buttons_frame,
                        text=button_text,
                        font=self.button_font,
                        bg="#FF9800",  # Orange
                        fg="white",
                        relief=tk.RAISED,
                        bd=3
                    )
                    button.grid(row=i, column=j, sticky="nsew", padx=2, pady=2)
                elif button_text == "C":
                    # Clear button
                    button = tk.Button(
                        buttons_frame,
                        text=button_text,
                        font=self.button_font,
                        bg="#F44336",  # Red
                        fg="white",
                        relief=tk.RAISED,
                        bd=3
                    )
                    button.grid(row=i, column=j, sticky="nsew", padx=2, pady=2)
                else:
                    # Number buttons and other controls
                    button = tk.Button(
                        buttons_frame,
                        text=button_text,
                        font=self.button_font,
                        bg="#2196F3" if button_text in ".()" else "#E0E0E0",  # Blue for special, gray for numbers
                        fg="white" if button_text in ".()" else "black",
                        relief=tk.RAISED,
                        bd=3
                    )
                    button.grid(row=i, column=j, sticky="nsew", padx=2, pady=2)
                
                # Bind button click events
                button.bind("<Button-1>", lambda event, text=button_text: self.button_click(text))
    
    def button_click(self, value):
        """
        Handle button clicks
        
        Args:
            value (str): The value of the button clicked
        """
        if value == "C":
            # Clear the display
            self.current_expression = ""
            self.update_display("0")
        elif value == "=":
            # Calculate the result
            try:
                if self.current_expression:
                    result = self.calculate_callback(self.current_expression)
                    self.update_display(result)
                    self.current_expression = str(result)
            except Exception as e:
                self.update_display(str(e))
                self.current_expression = ""
        else:
            # Add the value to the expression
            self.current_expression += value
            self.update_display(self.current_expression)
    
    def update_display(self, value):
        """
        Update the calculator display
        
        Args:
            value: The value to display
        """
        self.display.config(text=value)