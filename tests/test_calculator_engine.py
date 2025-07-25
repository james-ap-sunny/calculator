import pytest
from calculator_engine import CalculatorEngine

def test_addition():
    assert CalculatorEngine.calculate("2+2") == 4
    assert CalculatorEngine.calculate("0.1+0.2") == 0.3  # Test precision handling

def test_subtraction():
    assert CalculatorEngine.calculate("5-3") == 2
    assert CalculatorEngine.calculate("3-5") == -2

def test_multiplication():
    assert CalculatorEngine.calculate("3×4") == 12
    assert CalculatorEngine.calculate("2.5×2") == 5

def test_division():
    assert CalculatorEngine.calculate("8÷4") == 2
    assert CalculatorEngine.calculate("10÷3") == 3.3333333333

def test_division_by_zero():
    with pytest.raises(ZeroDivisionError, match="Error: Division by zero"):
        CalculatorEngine.calculate("5÷0")

def test_invalid_input():
    with pytest.raises(ValueError, match="Error: Invalid input"):
        CalculatorEngine.calculate("5+a")

def test_complex_expression():
    assert CalculatorEngine.calculate("(2+3)×4") == 20
    assert CalculatorEngine.calculate("2+(3×4)") == 14