//
//  ViewController.swift
//  adam-calc
//
//  Created by Adam Reed on 9/24/17.
//  Copyright © 2017 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds

// Variable for the current string of information on the main screen
var currentDisplay:String = ""
var operationIsDisplayed: Bool = false
var operatorType:String?
var firstNumber:Double?
var secondNumber:Double?
var answer:String = ""
var typeDoubleAnswer:Double?
var variableIsLocked: Bool = false



class ViewController: UIViewController {
    
    //Variables from the UI saved into my ViewController Class to be used in button functionality etc.
    @IBOutlet weak var mainDisplay: UILabel!
    @IBOutlet weak var variableButton: UIButton!
    
    // MARK: Google adwords variable
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    
    @IBOutlet weak var variableButtonLock: UIButton!
    
    
    
    //MARK: Clear Button Functionality
    @IBAction func clearButton(_ sender: UIButton) {
        currentDisplay = ""
        mainDisplay.text = currentDisplay
        firstNumber = nil
        secondNumber = nil
    }
    
    //MARK: Equals button functionality
    
    @IBAction func pressedEqualsButton(_ sender: UIButton) {
        
        let checkSecondNumber = String(mainDisplay.text!)
        
        
        // Check to see if firstNumber is not nil
        // Check to see if there is a second number available
        
        if firstNumber != nil && checkSecondNumber != nil && checkSecondNumber != "+" {
            
            secondNumber = Double(mainDisplay.text!)
            
            if operatorType == "+" {
                answer = String(format: "%.1f", firstNumber! + secondNumber!)
            }
            
            if operatorType == "-" {
                answer = String(format: "%.1f", firstNumber! - secondNumber!)
            }
            
            if operatorType == "/" {
                answer = String(format: "%.1f", firstNumber! / secondNumber!)
            }
            
            if operatorType == "x" {
                answer = String(format: "%.1f", firstNumber! * secondNumber!)
            }
            
            
        
        currentDisplay = answer
        mainDisplay.text = currentDisplay
        UserDefaults.standard.set(mainDisplay.text, forKey: "mainDisplay")
            
            
        if variableIsLocked == false {
            variableButton.setTitle(answer, for: .normal)
            UserDefaults.standard.set(variableButton.currentTitle, forKey: "variableInputButton")
        }
        
        firstNumber = nil
        secondNumber = nil
        operationIsDisplayed = true
            
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
        let inputRecieved = sender.tag - 1
        // Create a empty NumberPad Enumeration Variable for the switch statement to assign a value to
        var numberPressed = Int()
        
        switch inputRecieved {
        case 0:
            numberPressed = 0
        case 1:
            numberPressed = 1
        case 2:
            numberPressed = 2
        case 3:
            numberPressed = 3
        case 4:
            numberPressed = 4
        case 5:
            numberPressed = 5
        case 6:
            numberPressed = 6
        case 7:
            numberPressed = 7
        case 8:
            numberPressed = 8
        case 9:
            numberPressed = 9
        default:
            numberPressed = 0
        }
        
        // Clear out the currentDisplay variable if it contains a operator
        if currentDisplay == "/" || currentDisplay == "x" || currentDisplay == "-" || currentDisplay == "+" {
            currentDisplay = ""
        }
        
        // String the resulting value to send to the mainDisplay label
        let makeValueIntoString = String(describing: numberPressed)
        
        // Append the character the the end of the current string using the mainDisplay global variable
        currentDisplay.append(makeValueIntoString)
        // Update the mainDisplay's text by accessing and reassigning the global variable to the text object
        mainDisplay.text = currentDisplay
        
    }
 
    // MARK: Lock/Un-lock Button
    
    @IBAction func updateVariableButtonStatus(_ sender: UIButton) {
        
        if variableIsLocked == true {
            variableIsLocked = false
            variableButtonLock.setTitle("Un-Locked", for: .normal)
        }
        
        else {
            variableIsLocked = true
            variableButtonLock.setTitle("Locked", for: .normal)
        }
    }
    
    // MARK: Variable Button Input
    
    @IBAction func pressedVariableButton(_ sender: UIButton) {
        
        if firstNumber == nil {
            
            if Double(variableButton.currentTitle!) != nil {
            
                currentDisplay = variableButton.currentTitle!
                mainDisplay.text = currentDisplay
            }
            
        }
            
        else if secondNumber == nil {
            
            if Double(variableButton.currentTitle!) != nil {
                
                currentDisplay = variableButton.currentTitle!
                mainDisplay.text = currentDisplay
            
            }
        }
    }
    
    //MARK: Operator Button Functionality
 
    @IBAction func pressedOperatorButton(_ sender: UIButton) {
        
        // Ignore action if it contains a operator
        if currentDisplay == "/" || currentDisplay == "x" || currentDisplay == "-" || currentDisplay == "+" {
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
                answer = String(firstNumber! + secondNumber!)
            }
            
            if operatorType == "-" {
                answer = String(firstNumber! - secondNumber!)
            }
            
            if operatorType == "/" {
                answer = String(firstNumber! / secondNumber!)
            }
            
            if operatorType == "x" {
                answer = String(firstNumber! * secondNumber!)
            }
            
            // Update the answer box button
            variableButton.setTitle(answer, for: .normal)
            
            //Update the current display with the operation the user is performing
            currentDisplay = sender.currentTitle!
            mainDisplay.text = currentDisplay
            firstNumber = Double(answer)
            secondNumber = nil
            operatorType = sender.currentTitle
            
        } else {
            mainDisplay.text = "Please enter a number to start"
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // MARK: Google AdMob integration 
        
        GoogleBannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if let x = UserDefaults.standard.object(forKey: "variableInputButton") as? String {
            variableButton.setTitle(x, for: .normal)
        }
        
        if let y = UserDefaults.standard.object(forKey: "mainDisplay") as? String {
            mainDisplay.text = y
        }
        
    }
    
}

