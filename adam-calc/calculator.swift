//
//  calculator.swift
//  adam-calc
//
//  Created by Adam Reed on 9/30/17.
//  Copyright © 2017 rdConcepts. All rights reserved.
//

import Foundation

enum MathOperators {
    case add
    case subtract
    case divide
    case multiply
}


class OperatorMethods {
    
    func addOperation(_ firstNumber:Double, secondNumber:Double) -> Double {
        return firstNumber + secondNumber
    }
    
    func subtractOperation(_ firstNumber:Double, secondNumber:Double) -> Double {
        return firstNumber - secondNumber
    }
    
    func divideOperation(_ firstNumber:Double, secondNumber:Double) -> Double {
        return firstNumber / secondNumber
    }
    
    func multiplyOperation(_ firstNumber:Double, secondNumber:Double) -> Double {
        return firstNumber * secondNumber
    }
    
}


class DoTheMathOn: OperatorMethods {
    
    var firstNumber: Double
    var secondNumber: Double
    var operationType: MathOperators
    
    init(firstNumber: Double, secondNumber: Double, operationType: MathOperators) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        self.operationType = operationType
    }
    
    
    func performOperation(firstNumber: Double, secondNumber: Double, operationType: MathOperators) -> Double {
        switch operationType {
        case .add:
            return addOperation(firstNumber, secondNumber: secondNumber)
        case .subtract:
            return subtractOperation(firstNumber, secondNumber: secondNumber)
        case .divide:
            return divideOperation(firstNumber, secondNumber: secondNumber)
        case .multiply:
            return multiplyOperation(firstNumber, secondNumber: secondNumber)
        }
        
    }
    
    
}
