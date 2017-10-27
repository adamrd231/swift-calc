//
//  ViewController.swift
//  adam-calc
//
//  Created by Adam Reed on 9/24/17.
//  Copyright © 2017 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds


// MARK: Global Variables
// Variable for the current string of information on the main screen
var currentDisplay:String = ""
var operationIsDisplayed: Bool = false
var operatorType:String?
var firstNumber:Double?
var secondNumber:Double?
var answer:Double?
var string_answer:String = ""
var typeDoubleAnswer:Double?
var variable1IsLocked: Bool = false
var variable2IsLocked: Bool = false
var variable3IsLocked: Bool = false
var containsDecimal: Bool = false


// MARK: Main ViewController Class

class ViewController: UIViewController {
    
    //Variables from the UI saved into my ViewController Class to be used in button functionality etc.
    @IBOutlet weak var mainDisplay: UILabel!
    
    @IBOutlet weak var lockButtonText1: UIButton!
    @IBOutlet weak var lockButtonText2: UIButton!
    @IBOutlet weak var lockButtonText3: UIButton!
    
    @IBOutlet weak var variableButton1: UIButton!
    @IBOutlet weak var variableButton2: UIButton!
    @IBOutlet weak var variableButton3: UIButton!
    //Google AdMob Variable to access smart Banner
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    
    
    
    //MARK: Clear Button Functionality
    @IBAction func clearButton(_ sender: UIButton) {
        
        if variable1IsLocked == false {
            variableButton1.setTitle("( x )", for: .normal)
        }
        
        if variable2IsLocked == false {
            variableButton2.setTitle("( y )", for: .normal)
        }
        
        if variable3IsLocked == false {
            variableButton3.setTitle("( z )", for: .normal)
        }
        
        currentDisplay = ""
        mainDisplay.text = currentDisplay
        firstNumber = nil
        secondNumber = nil
        containsDecimal = false
    }
    
    //MARK: Equals button functionality
    
    @IBAction func pressedEqualsButton(_ sender: UIButton) {
        
        let checkSecondNumber = String(mainDisplay.text!)
        
        
        // Check to see if firstNumber is not nil
        // Check to see if there is a second number available
        
        if firstNumber != nil && checkSecondNumber != nil && checkSecondNumber != "+" {
            
            secondNumber = Double(mainDisplay.text!)
            
            if operatorType == "+" {
                answer = firstNumber! + secondNumber!
            }
            
            if operatorType == "-" {
                answer = firstNumber! - secondNumber!
            }
            
            if operatorType == "/" {
                answer = firstNumber! / secondNumber!
            }
            
            if operatorType == "x" {
                answer = firstNumber! * secondNumber!
            }
            
            string_answer = String(format: "%.2f", answer!)
        
        currentDisplay = string_answer
        mainDisplay.text = currentDisplay
        UserDefaults.standard.set(mainDisplay.text, forKey: "mainDisplay")
            
            
        if variable1IsLocked == false {
            variableButton1.setTitle(string_answer, for: .normal)
            UserDefaults.standard.set(variableButton1.currentTitle, forKey: "variableInputButton")
        }
            
        if variable2IsLocked == false {
            variableButton2.setTitle(string_answer, for: .normal)
            UserDefaults.standard.set(variableButton2.currentTitle, forKey: "variable2InputButton")
        }
        
        if variable3IsLocked == false {
            variableButton3.setTitle(string_answer, for: .normal)
            UserDefaults.standard.set(variableButton3.currentTitle, forKey: "variable3InputButton")
        }
            
        firstNumber = nil
        secondNumber = nil
        operationIsDisplayed = true
        containsDecimal = false
            
        }
        
    }
    
    // MARK: Backspace Key Functionality
    
    @IBAction func pressedBackspace(_ sender: Any) {
        if mainDisplay.text != "" {
            currentDisplay.removeLast()
            mainDisplay.text = currentDisplay
        } else {
            return
        }
        
    }
    
    

    
    // MARK: Number Pad Functionality
    @IBAction func pressedNumberPad(_ sender: UIButton) {
        
        if operationIsDisplayed == true {
            
            currentDisplay = ""
            mainDisplay.text = currentDisplay
            operationIsDisplayed = false
            
        }

            
        // Take the input from the tag on the button pressed, assign it to a readable variable
        let inputRecieved:String = String(sender.tag - 1)
        // Create a empty NumberPad Enumeration Variable for the switch statement to assign a value to
        var numberPressed = String()
        
        switch inputRecieved {
        case "20":
            numberPressed = "00"
        case "0":
            numberPressed = "0"
        case "1":
            numberPressed = "1"
        case "2":
            numberPressed = "2"
        case "3":
            numberPressed = "3"
        case "4":
            numberPressed = "4"
        case "5":
            numberPressed = "5"
        case "6":
            numberPressed = "6"
        case "7":
            numberPressed = "7"
        case "8":
            numberPressed = "8"
        case "9":
            numberPressed = "9"
        case "19":
            numberPressed = "."
        default:
            numberPressed = "cold"
        }
        
        // Clear out the currentDisplay variable if it contains a operator
        if currentDisplay == "/" || currentDisplay == "x" || currentDisplay == "-" || currentDisplay == "+" {
            currentDisplay = ""
        }
        
        
        for char in currentDisplay {
            
            if char == "." {
                containsDecimal = true
            }
            
        }
        
        if numberPressed == "." && containsDecimal == true {
            
            return
            
        }
        
        // Append the character the the end of the current string using the mainDisplay global variable
        currentDisplay.append(numberPressed)
        // Update the mainDisplay's text by accessing and reassigning the global variable to the text object
        mainDisplay.text = currentDisplay
        
    }
    
    
 
    // MARK: Lock/Un-lock Buttons
    
    @IBAction func updateVariableButtonStatus(_ sender: UIButton) {
        
        if variable1IsLocked == true {
            variable1IsLocked = false
            lockButtonText1.setTitle("Un-Locked", for: .normal)
            UserDefaults.standard.set(variable1IsLocked, forKey: "variableLockButton1")
        }
        else {
            variable1IsLocked = true
            lockButtonText1.setTitle("Locked", for: .normal)
            UserDefaults.standard.set(variable1IsLocked, forKey: "variableLockButton1")
        }
        
    }
    
    @IBAction func updateLockStatus2(_ sender: UIButton) {
        
        if variable2IsLocked == true {
            variable2IsLocked = false
            lockButtonText2.setTitle("Un-Locked", for: .normal)
            UserDefaults.standard.set(variable2IsLocked, forKey: "variableLockButton2")
        }
        else {
            variable2IsLocked = true
            lockButtonText2.setTitle("Locked", for: .normal)
            UserDefaults.standard.set(variable2IsLocked, forKey: "variableLockButton2")
        }
        
    }
    
    @IBAction func updateLockStatus3(_ sender: UIButton) {
        
        if variable3IsLocked == true {
            variable3IsLocked = false
            lockButtonText3.setTitle("Un-Locked", for: .normal)
            UserDefaults.standard.set(variable3IsLocked, forKey: "variableLockButton3")
        }
        else {
            variable3IsLocked = true
            lockButtonText3.setTitle("Locked", for: .normal)
            UserDefaults.standard.set(variable3IsLocked, forKey: "variableLockButton3")
        }
        
    }
    
    
    
    
    // MARK: Variable Button Input
    
    @IBAction func pressedVariableButton(_ sender: UIButton) {
        
        if firstNumber == nil {
            
            if Double(variableButton1.currentTitle!) != nil {
            
                currentDisplay = variableButton1.currentTitle!
                mainDisplay.text = currentDisplay
            }
            
        }
            
        else if secondNumber == nil {
            
            if Double(variableButton1.currentTitle!) != nil {
                
                currentDisplay = variableButton1.currentTitle!
                mainDisplay.text = currentDisplay
            
            }
        }
    }
    
    @IBAction func pressedVariableButton2(_ sender: Any) {
        
        if firstNumber == nil {
            
            if Double(variableButton2.currentTitle!) != nil {
                
                currentDisplay = variableButton2.currentTitle!
                mainDisplay.text = currentDisplay
            }
            
        }
            
        else if secondNumber == nil {
            
            if Double(variableButton2.currentTitle!) != nil {
                
                currentDisplay = variableButton2.currentTitle!
                mainDisplay.text = currentDisplay
                
            }
        }
    }
    
    @IBAction func pressedVariableButton3(_ sender: Any) {
        
        
        if firstNumber == nil {
            
            if Double(variableButton3.currentTitle!) != nil {
                
                currentDisplay = variableButton3.currentTitle!
                mainDisplay.text = currentDisplay
            }
            
        }
            
        else if secondNumber == nil {
            
            if Double(variableButton3.currentTitle!) != nil {
                
                currentDisplay = variableButton3.currentTitle!
                mainDisplay.text = currentDisplay
                
            }
        }
        
    }
    
    
    
    //MARK: Operator Button Functionality
 
    @IBAction func pressedOperatorButton(_ sender: UIButton) {
        
        // Ignore action if it contains a operator
        if currentDisplay == "/" || currentDisplay == "x" || currentDisplay == "-" || currentDisplay == "+" {
            //Update the current display with the operation the user is performing
            currentDisplay = sender.currentTitle!
            mainDisplay.text = currentDisplay
            operatorType = sender.currentTitle
            return
        }
        
        
        if firstNumber == nil {
            
            // If there is a number displayed on screen, save it to the first number variable
            firstNumber = Double(currentDisplay)
            
            //Update the current display with the operation the user is performing
            currentDisplay = sender.currentTitle!
            mainDisplay.text = currentDisplay
            operatorType = sender.currentTitle
            
            
        } else if secondNumber == nil {
            
            if let checkSecondNumber = Double(mainDisplay.text!) {
                secondNumber = checkSecondNumber
            }
            
            if operatorType == "+" {
                answer = firstNumber! + secondNumber!
            }
            
            if operatorType == "-" {
                answer = firstNumber! - secondNumber!
            }
            
            if operatorType == "/" {
                answer = firstNumber! / secondNumber!
            }
            
            if operatorType == "x" {
                answer = firstNumber! * secondNumber!
            }
            
            string_answer = String(format: "%.2f", answer!)
            
            // Update the variable answer buttons if not locked
            if variable1IsLocked == false {
                variableButton1.setTitle(string_answer, for: .normal)
            }
            
            if variable2IsLocked == false {
                variableButton2.setTitle(string_answer, for: .normal)
            }
            
            if variable3IsLocked == false {
                variableButton3.setTitle(string_answer, for: .normal)
            }
  
            
            //Update the current display with the operation the user is performing
            currentDisplay = sender.currentTitle!
            mainDisplay.text = currentDisplay
            firstNumber = Double(string_answer)
            secondNumber = nil
            operatorType = sender.currentTitle
            
        } else {
            mainDisplay.text = "Please enter a number to start"
        }
        
        containsDecimal = false
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: Google AdMob integration
        
        GoogleBannerView.adUnitID = "ca-app-pub-4186253562269967/3971400494"
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if let variable1 = UserDefaults.standard.object(forKey: "variableInputButton") as? String {
            variableButton1.setTitle(variable1, for: .normal)
        }
        
        if let variable2 = UserDefaults.standard.object(forKey: "variable2InputButton") as? String {
            variableButton2.setTitle(variable2, for: .normal)
        }
        
        if let variable3 = UserDefaults.standard.object(forKey: "variable3InputButton") as? String {
            variableButton3.setTitle(variable3, for: .normal)
        }
        
        if let variableLock1 = UserDefaults.standard.object(forKey: "variableLockButton1") as? Bool {
            if variableLock1 == false {
                variable1IsLocked = false
                lockButtonText1.setTitle("Un-Locked", for: .normal)
            }
            if variableLock1 == true {
                variable1IsLocked = true
                lockButtonText1.setTitle("Locked", for: .normal)
            }
        }
        
        if let variableLock2 = UserDefaults.standard.object(forKey: "variableLockButton2") as? Bool {
            if variableLock2 == false {
                variable2IsLocked = false
                lockButtonText2.setTitle("Un-Locked", for: .normal)
            }
            if variableLock2 == true {
                variable2IsLocked = true
                lockButtonText2.setTitle("Locked", for: .normal)
            }
        }
        
        if let variableLock3 = UserDefaults.standard.object(forKey: "variableLockButton3") as? Bool {
            if variableLock3 == false {
                variable3IsLocked = false
                lockButtonText3.setTitle("Un-Locked", for: .normal)
            }
            if variableLock3 == true {
                variable3IsLocked = true
                lockButtonText3.setTitle("Locked", for: .normal)
            }
        }
        
        
        
        if let mainDisplayNumber = UserDefaults.standard.object(forKey: "mainDisplay") as? String {
            mainDisplay.text = mainDisplayNumber
        }
        
    }
    
}

