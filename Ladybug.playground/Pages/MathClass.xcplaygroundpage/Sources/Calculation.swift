import Foundation

public enum Operation: String {
    case sum = "+",
        subtration = "-",
        multiplication = "*",
        division = "/"
}

public class Calculation {
    public var firstNumber: Int
    public var secondNumber: Int
    public var result: Int
    public var operation: Operation
    public var emptyField: Int
    
    public init(first: Int, second: Int, operation: Operation, emptyField: Int) {
        self.firstNumber = first
        self.secondNumber = second
        self.operation = operation
        self.emptyField = emptyField
        
        switch self.operation {
        case .sum:
            self.result = self.firstNumber + self.secondNumber
            break
        case .subtration:
            self.result = self.firstNumber - self.secondNumber
            break
        case .multiplication:
            self.result = self.firstNumber * self.secondNumber
            break
        case .division:
            self.result = self.firstNumber/self.secondNumber
            break
        }
    }
}

