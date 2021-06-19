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
    
    @State var decimalPlaces = 3
    var geometryDivisor = 8
    
    // MARK: Helper Functions
    func handleNumberInputs(title: String) {
        if operand == "" {
            if (leftNumber == "") {
                leftNumber = title
            } else {
                if leftNumber.contains(".") && title == "." {
                    return
                }
                leftNumber.append(title)
            }
        } else {
            if rightNumber == "" {
                rightNumber = title
            } else {
                if rightNumber.contains(".") && title == "." {
                    return
                }
                rightNumber.append(title)
            }
        }
        
    }
    
    
    func equalsOperand() {
        // Check to make sure all inputs are entered, otherwise return
        if leftNumber != "" && rightNumber != "" && operand != "" {
            
            // Setup float numbers from the inputs
            let floatLeftNumber = Float(leftNumber)
            let floatRightNumber = Float(rightNumber)
            var answer:String = ""
            
            
            // Perform the math operation based on the operand
            if operand == "x" {
                answer = (floatLeftNumber! * floatRightNumber!).clean
            } else if operand == "-" {
                answer = (floatLeftNumber! - floatRightNumber!).clean
            } else if operand == "+" {
                answer = (floatLeftNumber! + floatRightNumber!).clean
            } else {
                answer = (floatLeftNumber! / floatRightNumber!).clean
            }
            
            
            // Clear the operator inputs
            leftNumber = ""
            operand = ""
            rightNumber = ""
            
            
            if lockOne == "lock.fill" && lockTwo == "lock.fill" && lockThree == "lock.fill" {
                let floatAnswer = Float(answer)
                leftNumber = String(format: "%.\(decimalPlaces)f", floatAnswer!)
            } else {
                let floatAnswer = Float(answer)
                fillAnswerArrays(numberAsString: String(format: "%.\(decimalPlaces)f", floatAnswer!))
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
            let doubleLeftNumber = Float(leftNumber)
            let doubleRightNumber = Float(rightNumber)
            var answer:Float = 0
            
            if operand == "x" {
                answer = doubleLeftNumber! * doubleRightNumber!
            } else if operand == "-" {
                answer = doubleLeftNumber! - doubleRightNumber!
            } else if operand == "+" {
                answer = doubleLeftNumber! + doubleRightNumber!
            } else {
                answer = doubleLeftNumber! / doubleRightNumber!
            }
            
            leftNumber = String(format: "%.\(decimalPlaces)f", answer)
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
        ZStack() {
            // Setup backgound Color
            Color(.systemGray6).edgesIgnoringSafeArea([.top,.bottom])
            GeometryReader { geometry in
            
                VStack(alignment: .center){
                    
                    HStack {
                        Text("\(leftNumber)").frame(width: geometry.size.width / 3, height: geometry.size.height / CGFloat(geometryDivisor)).background(Color(.systemGray5))
                        Text("\(operand)").frame(width: geometry.size.width / 3, height: geometry.size.height / CGFloat(geometryDivisor)).background(Color(.systemGray4))
                        Text("\(rightNumber)").frame(width: geometry.size.width / 3, height: geometry.size.height / CGFloat(geometryDivisor)).background(Color(.systemGray5))
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor)).padding(.bottom)
                    

                    HStack {
                        Button( action: {
                            usingSavedAnswers(answer: savedAnswerArray[0])
                        }) {
                            
                            Text("\(savedAnswerArray[0])").frame(width: geometry.size.width / 3, height: geometry.size.height / CGFloat(geometryDivisor)).background(Color(.systemGray4))
                        }
                        Button( action: {
                            usingSavedAnswers(answer: savedAnswerArray[1])
                        }) {
                            
                            Text("\(savedAnswerArray[1])").frame(width: geometry.size.width / 3, height: geometry.size.height / CGFloat(geometryDivisor)).background(Color(.systemGray5))
                        }
                        Button( action: {
                            usingSavedAnswers(answer: savedAnswerArray[2])
                        }) {
                            
                            Text("\(savedAnswerArray[2])").frame(width: geometry.size.width / 3, height: geometry.size.height / CGFloat(geometryDivisor)).background(Color(.systemGray4))
                        }
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor))
                    
                    
                    HStack {
                        Button(action: {
                            if lockOne == "lock" {
                                lockOne = "lock.fill"
                            } else {
                                lockOne = "lock"
                            }
                        }) { Image(systemName: "\(lockOne)").frame(width: geometry.size.width / 3).font(.largeTitle) }
                        Button(action: {
                            if lockTwo == "lock" {
                                lockTwo = "lock.fill"
                            } else {
                                lockTwo = "lock"
                            }
                        }) { Image(systemName: "\(lockTwo)").frame(width: geometry.size.width / 3).font(.largeTitle) }
                        Button(action: {
                            if lockThree == "lock" {
                                lockThree = "lock.fill"
                            } else {
                                lockThree = "lock"
                            }
                        }) { Image(systemName: "\(lockThree)").frame(width: geometry.size.width / 3).font(.largeTitle) }
                        
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor))
                    
                    
                    HStack {
                        Button(action: {
                            handleNumberInputs(title: "1")
                        }) {
                            Text("1").frame(width: geometry.size.width / 5).font(.largeTitle)
                                
                        }
                        Button(action: {
                            handleNumberInputs(title: "2")
                        }) {
                            Text("2").frame(width: geometry.size.width / 5).font(.largeTitle)
                                
                        }
                        Button(action: {
                            handleNumberInputs(title: "3")
                        }) {
                            Text("3").frame(width: geometry.size.width / 5).font(.largeTitle)
                                
                        }
                        Button(action: {
                            handleOperandInputs(operandInput: "/")
                        }) {
                            Text("/").frame(width: geometry.size.width / 5).font(.largeTitle)
                                
                        }
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor)).padding(.leading).padding(.trailing)
                    
                    
                    HStack {
                        Button(action: {
                            handleNumberInputs(title: "4")
                        }) {
                            Text("4").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleNumberInputs(title: "5")
                        }) {
                            Text("5").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleNumberInputs(title: "6")
                        }) {
                            Text("6").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleOperandInputs(operandInput: "-")
                        }) {
                            Text("-").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor))
                    
                    
                    HStack {
                        Button(action: {
                            handleNumberInputs(title: "7")
                        }) {
                            Text("7").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleNumberInputs(title: "8")
                        }) {
                            Text("8").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleNumberInputs(title: "9")
                        }) {
                            Text("9").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleOperandInputs(operandInput: "x")
                        }) {
                            Text("x").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor))
                    
                    
                    HStack {
                        Button(action: {
                            backspaceClear()
                        }) {
                            Text("<").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleNumberInputs(title: "0")
                        }) {
                            Text("0").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleNumberInputs(title: ".")
                        }) {
                            Text(".").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                        Button(action: {
                            handleOperandInputs(operandInput: "+")
                        }) {
                            Text("+").frame(width: geometry.size.width / 5).font(.largeTitle)
                        }
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor))
                    
                    
                    HStack {
                        Button(action: {
                            clearButton()
                        }) {
                            Text("Clear").frame(width: geometry.size.width / 2).font(.largeTitle)
                        }
                        Button(action: {
                            equalsOperand()
                        }) {
                            Text("=").frame(width: geometry.size.width / 2).font(.largeTitle)
                        }
                    }.frame(height: geometry.size.height / CGFloat(geometryDivisor))
                    
                    
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }.padding()
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


extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
