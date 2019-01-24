//
//  ViewController.swift
//  adam-calc
//
//  Created by Adam Reed on 9/24/17.
//  Copyright © 2017 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds

// MARK: Main ViewController Class
class ViewController: UIViewController {
    // MARK: Global Variables
    // Variable for the current string of information on the main screen
    var calculator = Calculator()
    let numberFormatter = NumberFormatter()
    var placeholderLockedOne = false
    var placeholderLockedTwo = false
    var placeholderLockedThree = false
    let lockImage: UIImage = UIImage(named:"lockIcon")!
    let unLockImage: UIImage = UIImage(named:"unLockIcon")!
    

    //MARK: Setting up the calculator inputs for the first time.
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.answer = ""
        numberFormatter.numberStyle = .decimal
        //Set the format style for display

    }
    
    //MARK: IBOutlet Variables
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var operatorDisplay: UILabel!
    @IBOutlet weak var leftSideNumber: UILabel!
    @IBOutlet weak var rightSideNumber: UILabel!
    
    //MARK: IBAction outlets
    @IBAction func pressedClearButton(_ sender: Any) {
        calculator.clearButton(calc: calculator)
        updateLeftNumber()
        updateRightNumber()
        print(calculator.answer)
        updateDisplayLabels()
        updateOperator()
    }
    
    @IBAction func pressedBackspace(_ sender: Any) {
        
        if calculator.leftNumber == "" {
            return
        }
        
        if calculator.currentOperator != "" {
            if calculator.rightNumber == "" {
                return
            }
            calculator.rightNumber.removeLast()
            updateRightNumber()
        } else {
            calculator.leftNumber.removeLast()
            updateLeftNumber()
        }
        //backspaceButton()
    }
    
    @IBAction func pressedPeriodButton(_ sender: Any) {
        //periodButton()
        if calculator.leftNumber == "" {
            calculator.leftNumber = "0."
            leftSideNumber.text = calculator.leftNumber
            return
        }
        
        if calculator.currentOperator != "" {
            if calculator.rightNumber == "" {
                calculator.rightNumber = "0."
                rightSideNumber.text = calculator.rightNumber
                return
            }
            for char in calculator.rightNumber {
                if char == "." {
                    return
                }
            }
            calculator.rightNumber.append(".")
            rightSideNumber.text = calculator.rightNumber
        } else {
            for char in calculator.leftNumber {
                if char == "." {
                    return
                }
            }
            calculator.leftNumber.append(".")
            leftSideNumber.text = calculator.leftNumber
        }
        //backspaceButton()
        
    }
    
    @IBAction func pressedEqualsButton(_ sender: Any) {
        calculator.doingMath(calc: calculator, sender: "Equals")
        updateRightNumber()
        updateLeftNumber()
        updateDisplayLabels()
        updateVariableButtons()
    }
    
    @IBAction func PressedOperatorButton(_ sender: UIButton) {
        let operatorInput = sender.currentTitle
        
        if calculator.leftNumber == "" {
            return
        }
        
        // If no operator, select operator and save to operator display label
        if calculator.currentOperator == "" {
            calculator.currentOperator = operatorInput!
            updateOperator()
            
        // If user wants to change operator mid-operation, allows to update without performing the math
        } else if calculator.currentOperator != "" && calculator.rightNumber == "" {
            calculator.currentOperator = operatorInput!
            updateOperator()
            
        } else if calculator.currentOperator != "" && calculator.leftNumber != nil && calculator.rightNumber != nil {
            //operate the two numbers together
            calculator.doingMath(calc: calculator, sender: "Operator")
            // Set the new operator on the screen
            calculator.currentOperator = sender.title(for: .normal)!
            updateOperator()

            //display the answer
            updateDisplayLabels()
            updateLeftNumber()
            updateRightNumber()
            
        }
    }
    @IBAction func PressedNumberPad(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "Placeholder" {
            return
        }
        
        if calculator.answer != "" {
            
        }
        
        //Check to see if operator is selected
        //If no operator is currently selected
        if calculator.currentOperator == "" {
            // Check to make sure user has not already entered a number from the variable button
            if (sender.title(for: .normal)?.contains("."))! {
                if calculator.leftNumber.contains(".") {
                    return
                }
            }
            
            calculator.leftNumber.append(sender.title(for: .normal)!)
            if sender.title(for: .normal) == "0" {
                leftSideNumber.text = calculator.leftNumber
            } else {
                updateLeftNumber()
            }
            
        
        } else if calculator.currentOperator != ""  {
            // Check to make sure user has not already entered a number from the variable button
            if (sender.title(for: .normal)?.contains("."))! {
                if calculator.leftNumber.contains(".") {
                    return
                }
            }
            
            calculator.rightNumber.append(sender.title(for: .normal)!)
            if sender.title(for: .normal) == "0" {
                rightSideNumber.text = calculator.rightNumber
            } else {
                updateRightNumber()
            }
        }
    }
    
    @IBAction func pressedLockButtonOne(_ sender: Any) {
        placeholderLockedOne = switchTrueAndFalse(variable: placeholderLockedOne, button: lockButtonOne)
    }
    
    @IBAction func pressedLockButtonTwo(_ sender: Any) {
        placeholderLockedTwo = switchTrueAndFalse(variable: placeholderLockedTwo, button: lockButtonTwo)
    }
    
    @IBAction func pressedLockButtonThree(_ sender: Any) {
        placeholderLockedThree = switchTrueAndFalse(variable: placeholderLockedThree, button: lockButtonThree)
    }
    
    @IBOutlet weak var placeholderLabelOne: UIButton!
    @IBOutlet weak var lockButtonOne: UIButton!
    
    @IBOutlet weak var PlaceholderLabelTwo: UIButton!
    @IBOutlet weak var lockButtonTwo: UIButton!
    
    @IBOutlet weak var placeholderLabelThree: UIButton!
    @IBOutlet weak var lockButtonThree: UIButton!
    
    
    
    
    //MARK: Updating UI Buttons and Labels
    func updateVariableButtons() {
        if placeholderLockedOne == false {
            placeholderLabelOne.setTitle(numberFormatter.string(from: NSNumber(value: Double(calculator.answer)!)), for: .normal)
        }
        if placeholderLockedTwo == false {
            PlaceholderLabelTwo.setTitle(numberFormatter.string(from: NSNumber(value: Double(calculator.answer)!)), for: .normal)
        }
        if placeholderLockedThree == false {
            placeholderLabelThree.setTitle(numberFormatter.string(from: NSNumber(value: Double(calculator.answer)!)), for: .normal)
        }
    }
    
    func updateDisplayLabels() {
        if calculator.answer != "" {
            display.text = numberFormatter.string(from: NSNumber(value: Double(calculator.answer)!))
            operatorDisplay.text = calculator.currentOperator
        } else {
            display.text = ""
        }
    }

    func updateLeftNumber() {
        if calculator.leftNumber != "" {
            leftSideNumber.text = numberFormatter.string(from: NSNumber(value: Double(calculator.leftNumber)!))
        } else {
            leftSideNumber.text = ""
        }
    }
    
    func updateRightNumber() {
        if calculator.rightNumber != "" {
            rightSideNumber.text = numberFormatter.string(from: NSNumber(value: Double(calculator.rightNumber)!))
        } else {
            rightSideNumber.text = ""
        }
    }
    
    func updateOperator() {
            operatorDisplay.text = calculator.currentOperator
    }
    
    func switchTrueAndFalse(variable: Bool, button: UIButton) -> Bool {
        if variable == false {
            button.setImage(lockImage, for: .normal)
            return true
        } else {
            button.setImage(unLockImage, for: .normal)
            return false
        }
    }
    
}

