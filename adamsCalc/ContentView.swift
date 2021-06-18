//
//  ContentView.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/17/21.
//

import SwiftUI



struct ContentView: View {
    
    // Variables for Calculator
    @State var currentAnswer = ""
    @State var leftNumber = ""
    @State var rightNumber = ""
    @State var operand = ""
    
    var isTyping = true
    
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
    
    func handleOperandInputs(operandInput: String) {
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
            return
        }
        
    }
    

    
    var body: some View {
        VStack(spacing: 30){
            HStack {
                Text("\(leftNumber)")
                Text("\(operand)")
                Text("\(rightNumber)")
                Text("\(currentAnswer)")
            }
            

            HStack {
                Button("Place", action: {
                    
                })
                Button("Place", action: {
                    
                })
                Button("Place", action: {
                    
                })
            }
            HStack {
                Button("Lock", action: {
                    
                })
                Button("Lock", action: {
                    
                })
                Button("Lock", action: {
                    
                })
            }
            HStack {
                Button("1", action: {
                    handleNumberInputs(title: "1")
                })
                Button("2", action: {
                    
                })
                Button("3", action: {
                    
                })
                Button("/", action: {
                    
                })
            }
            HStack {
                Button("4", action: {
                    
                })
                Button("5", action: {
                    
                })
                Button("6", action: {
                    
                })
                Button("-", action: {
                    handleOperandInputs(operandInput: "-")
                })
            }
            HStack {
                Button("7", action: {
                    
                })
                Button("8", action: {
                    
                })
                Button("9", action: {
                    
                })
                Button("x", action: {
                    
                })
            }
            HStack {
                Button("<", action: {
                    
                })
                Button("0", action: {
                    
                })
                Button(".", action: {
                    
                })
                Button("+", action: {
                    handleOperandInputs(operandInput: "+")
                })
            }
            HStack {
                Button("Clear", action: {
                    
                })
                Button("=", action: {
                    
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
