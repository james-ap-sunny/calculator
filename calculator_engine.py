class CalculatorEngine:
    """Handles the calculation logic for the calculator application"""
    
    @staticmethod
    def calculate(expression):
        """
        Calculate the result of a mathematical expression
        
        Args:
            expression (str): The mathematical expression to evaluate
            
        Returns:
            float: The result of the calculation
            
        Raises:
            ValueError: If the expression is invalid
            ZeroDivisionError: If division by zero is attempted
        """
        try:
            # Replace 'x' with '*' for multiplication
            expression = expression.replace('×', '*')
            # Replace '÷' with '/' for division
            expression = expression.replace('÷', '/')
            
            # Validate the expression
            CalculatorEngine.validate_input(expression)
            
            # Use eval() with caution - in a production environment,
            # consider using a safer alternative like ast.literal_eval
            # or implementing a custom parser
            result = eval(expression)
            
            # Format the result to avoid floating point precision issues
            if isinstance(result, float):
                # Format to 10 decimal places and remove trailing zeros
                result_str = f"{result:.10f}".rstrip('0').rstrip('.')
                return float(result_str) if '.' in result_str else int(result_str)
            return result
            
        except ZeroDivisionError:
            raise ZeroDivisionError("Error: Division by zero")
        except Exception as e:
            raise ValueError(f"Error: Invalid input")
    
    @staticmethod
    def validate_input(expression):
        """
        Validate that the expression contains only allowed characters
        
        Args:
            expression (str): The expression to validate
            
        Raises:
            ValueError: If the expression contains invalid characters
        """
        # Allow digits, operators, parentheses, and decimal points
        allowed_chars = set("0123456789+-*/().× ")
        if not all(char in allowed_chars for char in expression):
            raise ValueError("Error: Invalid input")
        
        # Additional validation could be added here
        # For example, checking for balanced parentheses