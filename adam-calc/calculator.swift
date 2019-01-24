//
//  Calculator.swift
//  adam-calc
//
//  Created by Adam Reed on 1/16/19.
//  Copyright © 2019 rdConcepts. All rights reserved.
//

import Foundation

class Calculator {

    var leftNumber:String = ""
    var rightNumber:String = ""
    var answer:String = ""
    var placeholderOne = ""
    var placeholderTwo = ""
    var placeholderThree = ""
    var currentOperator:String = ""
    
    let numberFormatter = NumberFormatter()
    
    func doingMath(calc: Calculator, sender: String) {
        
        
        let left = Double(calc.leftNumber)
        let right = Double(calc.rightNumber)
        
        if calc.leftNumber != "" && calc.rightNumber != "" {
            
            if calc.currentOperator == "+" {
                let answer = String(left! + right!)
                print(answer)
                operatorOrEquals(calc: calc, answer: answer, sender: sender)
            }
            
            if calc.currentOperator == "-" {
                let answer = String(left! - right!)
                operatorOrEquals(calc: calc, answer: answer, sender: sender)
            }
            
            if calc.currentOperator == "/" {
                let answer = left! / right!
                print(answer)
                let newAnswer = String(answer)
                print(newAnswer)
                operatorOrEquals(calc: calc, answer: newAnswer, sender: sender)
            }
            
            if calc.currentOperator == "x" {
                let answer = String(left! * right!)
                operatorOrEquals(calc: calc, answer: answer, sender: sender)
            }
          
            // Function to differientiate action from equals and operator signs

        }
        
       
    }
    
    func operatorOrEquals(calc: Calculator, answer: String, sender:String) {
        if sender == "Operator" {
            calc.leftNumber = answer
            calc.answer = answer
            calc.rightNumber = ""
        }
        
        if sender == "Equals" {
            calc.answer = String(answer)
            calc.currentOperator = ""
            calc.leftNumber = ""
            calc.rightNumber = ""
        }
    }

    
    func clearButton(calc: Calculator) {
        calc.answer = ""
        calc.leftNumber = ""
        calc.rightNumber = ""
        calc.currentOperator = ""
    }
    
}
