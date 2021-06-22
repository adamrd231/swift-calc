//
//  ContentView.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/17/21.
//

import SwiftUI



struct ContentView: View {

    
   
    @EnvironmentObject var calculator: Calculator
    
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
        GeometryReader { geometry in
        ZStack {
            // Setup backgound Color
            Color(.systemGray6).edgesIgnoringSafeArea([.top,.bottom])
            
            
                VStack(alignment: .center){
                    
                    HStack {
                        Text("\(calculator.leftNumber)")
                        Text("\(calculator.operand)")
                        Text("\(calculator.rightNumber)")
                    }
                    

                    HStack {
                        ForEach(0...calculator.savedAnswerArray.count - 1, id: \.self) { savedAnswer in
                            Button( action: {
                                calculator.usingSavedAnswers(answer: calculator.savedAnswerArray[savedAnswer])
                            }) {
                                Text("\(calculator.savedAnswerArray[savedAnswer])")
                            }
                        }
                    }
                    
                    
                    HStack {
                        Button(action: {
                            calculator.lockOne = toggleButtonStatus(boolVariable: calculator.lockOne)
                        }) { displayLockImage(boolVariable: calculator.lockOne) }
                        Button(action: {
                            calculator.lockTwo = toggleButtonStatus(boolVariable: calculator.lockTwo)
                        }) { displayLockImage(boolVariable: calculator.lockTwo) }
                        Button(action: {
                            calculator.lockThree = toggleButtonStatus(boolVariable: calculator.lockThree)
                        }) { displayLockImage(boolVariable: calculator.lockThree) }
                    }
                    
                    
                    VStack(alignment: .center) {
                        ForEach(calculator.numberPadButtons, id: \.self) { row in
                            HStack {
                                ForEach(row, id: \.self) { item in
                                    Button(action:{
                                        switch item.rawValue {
                                        case "1": calculator.handleNumberInputs(title: "1")
                                        case "2": calculator.handleNumberInputs(title: "2")
                                        case "3": calculator.handleNumberInputs(title: "3")
                                        case "4": calculator.handleNumberInputs(title: "4")
                                        case "5": calculator.handleNumberInputs(title: "5")
                                        case "6": calculator.handleNumberInputs(title: "6")
                                        case "7": calculator.handleNumberInputs(title: "7")
                                        case "8": calculator.handleNumberInputs(title: "8")
                                        case "9": calculator.handleNumberInputs(title: "9")
                                        case "0": calculator.handleNumberInputs(title: "0")
                                        case "/": calculator.handleOperandInputs(operandInput: "/")
                                        case "*": calculator.handleOperandInputs(operandInput: "*")
                                        case "-": calculator.handleOperandInputs(operandInput: "-")
                                        case "+": calculator.handleOperandInputs(operandInput: "+")
                                        case ".": calculator.handleNumberInputs(title: ".")
                                        case "<": calculator.backspaceClear()
                                        case "=": calculator.equalsOperand()
                                        case "AC": calculator.clearButton()
                                            default: return
                                        }
  
                                    }) {
                                        Text(item.rawValue)
                                    }.buttonStyle(NumberPadButtonStyle())
                                }
                            }
                        }
                    }
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(Calculator())
        }
    }
}





extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
