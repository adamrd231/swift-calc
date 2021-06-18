//
//  ContentView.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/17/21.
//

import SwiftUI



struct ContentView: View {
    
    // Variables for Calculator
    @State var leftNumber = ""
    @State var rightNumber = ""
    @State var operand = ""
    
    @State var savedAnswerArray = ["", "", ""]
    
    @State var lockOne = "lock"
    @State var lockTwo = "lock"
    @State var lockThree = "lock"
    
    // MARK: Helper Functions
    func handleNumberInputs(title: String) {
        if operand == "" {
            if (leftNumber == "") {
                leftNumber = title
            } else {
                leftNumber.append(title)
            }
        } else {
            if rightNumber == "" {
                rightNumber = title
            } else {
                rightNumber.append(title)
            }
        }
        
    }
    
    func equalsOperand() {
        if leftNumber != "" && rightNumber != "" && operand != "" {
            // Use number and operator inputs to do math
            let doubleLeftNumber = Double(leftNumber)
            let doubleRightNumber = Double(rightNumber)
            var answer = 0.0
            
            if operand == "x" {
                answer = doubleLeftNumber! * doubleRightNumber!
            } else if operand == "-" {
                answer = doubleLeftNumber! - doubleRightNumber!
            } else if operand == "+" {
                answer = doubleLeftNumber! + doubleRightNumber!
            } else {
                answer = doubleLeftNumber! / doubleRightNumber!
            }
            
            leftNumber = ""
            operand = ""
            rightNumber = ""
            
            
            if lockOne == "lock.fill" && lockTwo == "lock.fill" && lockThree == "lock.fill" {
                leftNumber = String(answer)
            } else {
                fillAnswerArrays(numberAsString: String(answer))
            }
            
            
        } else {
            return
        }
    }
    
    func continuedOperatation(newOperator: String) {
        
        if leftNumber.last == "." {
            leftNumber.removeLast()
        }
        if rightNumber.last == "." {
            rightNumber.removeLast()
        }
        
        if leftNumber != "" && rightNumber != "" && operand != "" {
            // Use number and operator inputs to do math
            let doubleLeftNumber = Double(leftNumber)
            let doubleRightNumber = Double(rightNumber)
            var answer = 0.0
            
            if operand == "x" {
                answer = doubleLeftNumber! * doubleRightNumber!
            } else if operand == "-" {
                answer = doubleLeftNumber! - doubleRightNumber!
            } else if operand == "+" {
                answer = doubleLeftNumber! + doubleRightNumber!
            } else {
                answer = doubleLeftNumber! / doubleRightNumber!
            }
            
            leftNumber = String(answer)
            operand = newOperator
            rightNumber = ""
            
            
            
            fillAnswerArrays(numberAsString: leftNumber)
            
        } else {
            return
        }
    }
    
    func handleOperandInputs(operandInput: String) {
        
        if leftNumber.last == "." {
            leftNumber.removeLast()
        }
        if rightNumber.last == "." {
            rightNumber.removeLast()
        }

        
        
        // Check place in calculator sequence
        // if leftNumber has not been entered, do nothing
        if leftNumber == "" {
            return
        // if leftNumber is filled, choose operator
        } else if leftNumber != "" && operand == "" {
            operand = operandInput
        // if leftNumber is filled and operator, replace operator
        } else if leftNumber != "" && operand != "" && rightNumber == "" {
            operand = operandInput
        // if leftNumber is filled, operator and rightnumber being filled, do nothing
        } else {
            continuedOperatation(newOperator: operandInput)
        }
        
    }
    
    func clearButton() {
        leftNumber = ""
        rightNumber = ""
        operand = ""
        
        if lockOne == "lock" {
            savedAnswerArray[0] = ""
        }
        if lockTwo == "lock" {
            savedAnswerArray[1] = ""
        }
        if lockThree == "lock" {
            savedAnswerArray[2] = ""
        }
        
        
        
        
    }
    
    func backspaceClear() {
        if leftNumber != "" && operand != "" && rightNumber != "" {
            rightNumber.removeLast()
        } else if leftNumber != "" && operand != "" {
            operand = ""
        } else if leftNumber != "" {
            leftNumber.removeLast()
        } else {
            return
        }
    }
    

    
    func fillAnswerArrays(numberAsString: String) {
        
        if savedAnswerArray[0] == "" && lockOne == "lock" {
            savedAnswerArray[0] = numberAsString
        } else if savedAnswerArray[1] == "" && lockTwo == "lock" {
            savedAnswerArray[1] = numberAsString
        } else if savedAnswerArray[2] == "" && lockThree == "lock" {
            savedAnswerArray[2] = numberAsString
           
        } else if savedAnswerArray[2] != "" && lockThree == "lock" {
            savedAnswerArray[2] = numberAsString
        } else if savedAnswerArray[1] != "" && lockTwo == "lock"  {
            savedAnswerArray[1] = numberAsString
        } else if savedAnswerArray[0] != "" && lockOne == "lock" {
            savedAnswerArray[0] = numberAsString
        }
    }
    
    func usingSavedAnswers(answer: String) {
        if leftNumber == "" {
            leftNumber = answer
        } else if leftNumber != "" && operand == "" {
            leftNumber = answer
        } else if operand != "" && leftNumber != "" && rightNumber == "" {
            rightNumber = answer
        } else {
            rightNumber = answer
        }
    }
    

    // MARK: App UI
    var body: some View {
        VStack(spacing: 30){
            HStack {
                Text("\(leftNumber)")
                Text("\(operand)")
                Text("\(rightNumber)")
            }
            

            HStack {
                Button( action: {
                    usingSavedAnswers(answer: savedAnswerArray[0])
                }) {
                    Text("\(savedAnswerArray[0])")
                }
                Button( action: {
                    usingSavedAnswers(answer: savedAnswerArray[1])
                }) {
                    Text("\(savedAnswerArray[1])")
                }
                Button( action: {
                    usingSavedAnswers(answer: savedAnswerArray[2])
                }) {
                    Text("\(savedAnswerArray[2])")
                }
            }
            HStack {
                Button(action: {
                    if lockOne == "lock" {
                        lockOne = "lock.fill"
                    } else {
                        lockOne = "lock"
                    }
                }) { Image(systemName: "\(lockOne)") }
                Button(action: {
                    if lockTwo == "lock" {
                        lockTwo = "lock.fill"
                    } else {
                        lockTwo = "lock"
                    }
                }) { Image(systemName: "\(lockTwo)") }
                Button(action: {
                    if lockThree == "lock" {
                        lockThree = "lock.fill"
                    } else {
                        lockThree = "lock"
                    }
                }) { Image(systemName: "\(lockThree)") }
            }
            HStack {
                Button("1", action: {
                    handleNumberInputs(title: "1")
                })
                Button("2", action: {
                    handleNumberInputs(title: "2")
                })
                Button("3", action: {
                    handleNumberInputs(title: "3")
                })
                Button("/", action: {
                    handleOperandInputs(operandInput: "/")
                })
            }
            HStack {
                Button("4", action: {
                    handleNumberInputs(title: "4")
                })
                Button("5", action: {
                    handleNumberInputs(title: "5")
                })
                Button("6", action: {
                    handleNumberInputs(title: "6")
                })
                Button("-", action: {
                    handleOperandInputs(operandInput: "-")
                })
            }
            HStack {
                Button("7", action: {
                    handleNumberInputs(title: "7")
                })
                Button("8", action: {
                    handleNumberInputs(title: "8")
                })
                Button("9", action: {
                    handleNumberInputs(title: "9")
                })
                Button("x", action: {
                    handleOperandInputs(operandInput: "x")
                })
            }
            HStack {
                Button("<", action: {
                    backspaceClear()
                })
                Button("0", action: {
                    handleNumberInputs(title: "0")
                })
                Button(".", action: {
                    handleNumberInputs(title: ".")
                })
                Button("+", action: {
                    handleOperandInputs(operandInput: "+")
                })
            }
            HStack {
                Button("Clear", action: {
                    clearButton()
                })
                Button("=", action: {
                    equalsOperand()
                })
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
