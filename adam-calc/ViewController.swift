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
    let lockImage: UIImage = UIImage(named:"lockIcon")!
    let unLockImage: UIImage = UIImage(named:"unLockIcon")!
    
    var firstTimer = false
    
    var dataModel: DataModel!

    //MARK: Setting up the calculator inputs for the first time.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:= google Adwords
        // Test AdMob Banner ID
        //GoogleBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        
        // Live AdMob Banner ID
        GoogleBannerView.adUnitID = "ca-app-pub-4186253562269967/3971400494"
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())

        numberFormatter.numberStyle = .decimal
        //Set the format style for display
        
        firstTimer = defaults.bool(forKey: "FirstTimer")
        
        if firstTimer == false {
            calculator.answer = "Hello"
            display.text = calculator.answer
            firstTimer = true
            defaults.set(firstTimer, forKey: "FirstTimer")
        } else {
            loadCalculator()
            updateOperator()
            updateLeftNumber()
        }
        
        

    }


    //MARK: IBOutlet Variables
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var operatorDisplay: UILabel!
    @IBOutlet weak var leftSideNumber: UILabel!
    @IBOutlet weak var rightSideNumber: UILabel!
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    
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
            saveCalculator()
        } else {
            calculator.leftNumber.removeLast()
            updateLeftNumber()
            saveCalculator()
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
        updateAnswerVariableButtons()
        saveCalculator()
    }
    
    @IBAction func PressedOperatorButton(_ sender: UIButton) {
        let operatorInput = sender.currentTitle
        
        if calculator.leftNumber == "" && calculator.answer != "" {
            calculator.leftNumber = calculator.answer
            calculator.answer = ""
            calculator.currentOperator = sender.currentTitle!
            updateLeftNumber()
            updateOperator()
            updateDisplayLabels()
        }
        
        if calculator.leftNumber == "" {
            return
        }
        
        
        // If no operator, select operator and save to operator display label
        if calculator.currentOperator == "" {
            calculator.currentOperator = operatorInput!
            updateOperator()
            saveCalculator()
            
        // If user wants to change operator mid-operation, allows to update without performing the math
        } else if calculator.currentOperator != "" && calculator.rightNumber == "" {
            calculator.currentOperator = operatorInput!
            updateOperator()
            saveCalculator()
            
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
            saveCalculator()
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
                saveCalculator()
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
                saveCalculator()
            }
        }
        
        saveCalculator()
    }
    
    @IBAction func pressedLockButtonOne(_ sender: Any) {
        calculator.lockButtonOne = switchTrueAndFalse(variable: calculator.lockButtonOne, button: lockButtonOne)
        updateLockButtons()
        saveCalculator()
    }
    
    @IBAction func pressedLockButtonTwo(_ sender: Any) {
        calculator.lockButtonTwo = switchTrueAndFalse(variable: calculator.lockButtonTwo, button: lockButtonTwo)
        updateLockButtons()
        saveCalculator()
    }
    
    @IBAction func pressedLockButtonThree(_ sender: Any) {
        calculator.lockButtonThree = switchTrueAndFalse(variable: calculator.lockButtonThree, button: lockButtonThree)
        updateLockButtons()
        saveCalculator()
    }
    
    @IBOutlet weak var placeholderLabelOne: UIButton!
    @IBOutlet weak var lockButtonOne: UIButton!
    
    @IBOutlet weak var PlaceholderLabelTwo: UIButton!
    @IBOutlet weak var lockButtonTwo: UIButton!
    
    @IBOutlet weak var placeholderLabelThree: UIButton!
    @IBOutlet weak var lockButtonThree: UIButton!
    
    
    
    
    //MARK: Updating UI Buttons and Labels
    func updateAnswerVariableButtons() {
        if calculator.lockButtonOne == false {
            calculator.placeholderOne = calculator.answer
            placeholderLabelOne.setTitle(numberFormatter.string(from: NSNumber(value: Double(calculator.answer)!)), for: .normal)
        }
        if calculator.lockButtonTwo == false {
            calculator.placeholderTwo = calculator.answer
            PlaceholderLabelTwo.setTitle(numberFormatter.string(from: NSNumber(value: Double(calculator.answer)!)), for: .normal)
        }
        if calculator.lockButtonThree == false {
            calculator.placeholderThree = calculator.answer
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
            
            while calculator.leftNumber.contains(",") {
                if let i = calculator.leftNumber.firstIndex(of: ",") {
                    calculator.leftNumber.remove(at: i)
                }
            }

            leftSideNumber.text = numberFormatter.string(from: NSNumber(value: Double(calculator.leftNumber)!))
        } else {
            leftSideNumber.text = ""
        }
    }
    
    func updateRightNumber() {
        if calculator.rightNumber != "" {
            
            while calculator.rightNumber.contains(",") {
                if let i = calculator.rightNumber.firstIndex(of: ",") {
                    calculator.rightNumber.remove(at: i)
                }
            }
            rightSideNumber.text = numberFormatter.string(from: NSNumber(value: Double(calculator.rightNumber)!))
        } else {
            rightSideNumber.text = ""
        }
    }
    
    func updateOperator() {
            operatorDisplay.text = calculator.currentOperator
    }
    
    func updateLockButtons() {
        if calculator.lockButtonOne == true {
            lockButtonOne.setImage(lockImage, for: .normal)
            lockButtonOne.backgroundColor = UIColor.darkGray
        } else {
            lockButtonOne.setImage(unLockImage, for: .normal)
            lockButtonOne.backgroundColor = UIColor.lightGray
        }
        
        if calculator.lockButtonTwo == true {
            lockButtonTwo.setImage(lockImage, for: .normal)
            lockButtonTwo.backgroundColor = UIColor.darkGray
        } else {
            lockButtonTwo.setImage(unLockImage, for: .normal)
            lockButtonTwo.backgroundColor = UIColor.lightGray
        }
        
        if calculator.lockButtonThree == true {
            lockButtonThree.setImage(lockImage, for: .normal)
            lockButtonThree.backgroundColor = UIColor.darkGray
        } else {
            lockButtonThree.setImage(unLockImage, for: .normal)
            lockButtonThree.backgroundColor = UIColor.lightGray
        }
      
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
    
    
    
    func saveCalculator() {
        let array:[String] = [calculator.answer, calculator.leftNumber, calculator.rightNumber, calculator.currentOperator, calculator.placeholderOne, calculator.placeholderTwo, calculator.placeholderThree]
        defaults.set(array, forKey: "SavedArray")
        
        let lockArray:[Bool] = [calculator.lockButtonOne, calculator.lockButtonTwo, calculator.lockButtonThree]
        defaults.set(lockArray, forKey: "SavedLockStatus")
        
        print((lockArray))
//        defaults.set(PlaceholderLabelTwo, forKey: "LockButtonTwo")
//        defaults.set(placeholderLabelThree, forKey: "LockButtonThree")
        

    }
    
    func loadCalculator() {
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        
        if savedArray.count == 7 {
            //Assign the saved value
            calculator.answer = savedArray[0]
            //Display the value on the calculator
            updateDisplayLabels()
            
            calculator.leftNumber = savedArray[1]
            updateLeftNumber()
            
            calculator.rightNumber = savedArray[2]
            updateRightNumber()
            
            calculator.currentOperator = savedArray[3]
            updateOperator()
            
            calculator.placeholderOne = savedArray[4]
            calculator.placeholderTwo = savedArray[5]
            calculator.placeholderThree = savedArray[5]
            updateAnswerVariableButtons()
       
        }
        
        let lockArray = defaults.object(forKey: "SavedLockStatus") as? [Bool] ?? [Bool]()
        
        if lockArray.count == 3 {
            calculator.lockButtonOne = lockArray[0]
            calculator.lockButtonTwo = lockArray[1]
            calculator.lockButtonThree = lockArray[2]
            
            print(lockArray[0], lockArray[1], lockArray[2])
            updateLockButtons()
           
        }
        


//        PlaceholderLabelTwo = defaults.object(forKey: "LockButtonTwo") as! UIButton
//        placeholderLabelThree = defaults.object(forKey: "LockButtonThree")
       
    }
    
    
    let defaults = UserDefaults.standard

    
    
}

