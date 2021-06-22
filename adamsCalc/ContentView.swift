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
    
    @State var savedAnswerArray = ["1", "2", "3"]
    
    @State var lockOne = false
    @State var lockTwo = false
    @State var lockThree = false
    @State var locksStatus = [false, true, false]
    
    
    // UI Settings that users might be able to adjust
    @State var decimalPlaces = 3
    
    // UI Setting for layout
    var geometryDivisor = 8
    
    enum NumberPadButtons:String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case zero = "0"
        case add = "+"
        case period = "."
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case equals = "="
        case clear = "AC"
        case negativePostive = "+/-"
        case percentage = "%"
        case backSpace = "<"
    }
    
    let numberPadButtons: [[NumberPadButtons]] = [
        [.clear, .backSpace, .negativePostive, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .period, .equals]
    ]
    
    
    
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
            
            
            if lockOne == true && lockTwo == true && lockThree == true {
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
        
        if lockOne == false {
            savedAnswerArray[0] = ""
        }
        if lockTwo == false {
            savedAnswerArray[1] = ""
        }
        if lockThree == false {
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
        
        if savedAnswerArray[0] == "" && lockOne == false {
            savedAnswerArray[0] = numberAsString
        } else if savedAnswerArray[1] == "" && lockTwo == false {
            savedAnswerArray[1] = numberAsString
        } else if savedAnswerArray[2] == "" && lockThree == false {
            savedAnswerArray[2] = numberAsString
           
        } else if savedAnswerArray[2] != "" && lockThree == false {
            savedAnswerArray[2] = numberAsString
        } else if savedAnswerArray[1] != "" && lockTwo == false  {
            savedAnswerArray[1] = numberAsString
        } else if savedAnswerArray[0] != "" && lockOne == false {
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
    
    func toggleButtonStatus(boolVariable: Bool) -> Bool {
        var newBool = boolVariable
        newBool.toggle()
        return newBool
    }
    
    func displayLockImage(boolVariable:Bool) -> Image {
        if boolVariable == false {
            return Image(systemName: "lock")
        } else {
            return Image(systemName: "lock.fill")
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
                        Text("\(leftNumber)")
                        Text("\(operand)")
                        Text("\(rightNumber)")
                    }
                    

                    HStack {
                        ForEach(0...savedAnswerArray.count - 1, id: \.self) { savedAnswer in
                            Button( action: {
                                usingSavedAnswers(answer: savedAnswerArray[savedAnswer])
                                print(savedAnswerArray[savedAnswer])
                            }) {
                                
                                Text("\(savedAnswerArray[savedAnswer])")
                            }
                        }
                    }
                    
                    
                    HStack {
                        Button(action: {
                            lockOne = toggleButtonStatus(boolVariable: lockOne)
                        }) { displayLockImage(boolVariable: lockOne) }
                        Button(action: {
                            lockTwo = toggleButtonStatus(boolVariable: lockTwo)
                        }) { displayLockImage(boolVariable: lockTwo) }
                        Button(action: {
                            lockThree = toggleButtonStatus(boolVariable: lockThree)
                        }) { displayLockImage(boolVariable: lockThree) }
                    }
                    
                    
                    VStack {
                        ForEach(numberPadButtons, id: \.self) { row in
                            HStack {
                                ForEach(row, id: \.self) { item in
                                    Button(action:{
                                        switch item.rawValue {
                                            case "1": handleNumberInputs(title: "1")
                                            case "2": handleNumberInputs(title: "2")
                                            case "3": handleNumberInputs(title: "3")
                                            case "4": handleNumberInputs(title: "4")
                                            case "5": handleNumberInputs(title: "5")
                                            case "6": handleNumberInputs(title: "6")
                                            case "7": handleNumberInputs(title: "7")
                                            case "8": handleNumberInputs(title: "8")
                                            case "9": handleNumberInputs(title: "9")
                                            case "0": handleNumberInputs(title: "0")
                                            case "/": handleOperandInputs(operandInput: "/")
                                            case "*": handleOperandInputs(operandInput: "*")
                                            case "-": handleOperandInputs(operandInput: "-")
                                            case "+": handleOperandInputs(operandInput: "+")
                                            case ".": handleNumberInputs(title: ".")
                                            case "<": backspaceClear()
                                            case "=": equalsOperand()
                                            case "AC": clearButton()
                                            default: return
                                        }
  
                                    }) {
                                        Text(item.rawValue)
                                    }.buttonStyle(NumberPadButtonStyle())
                                }
                            }
                        }
                    }
                }
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





extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
