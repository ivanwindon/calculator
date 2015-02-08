//
//  ViewController.swift
//  Calculator
//
//  Created by Ivan Windon on 2/6/15.
//  Copyright (c) 2015 Ivan Windon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    let x = M_PI
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalIsPressed = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
    }
    var decimalIsPressed = false

    @IBAction func decimal() {
        userIsInTheMiddleOfTypingANumber = true
        if decimalIsPressed == false {
            display.text = display.text! + "."
            decimalIsPressed = true
        }
    }
    
    @IBAction func pi() {
        userIsInTheMiddleOfTypingANumber = true
        if display.text != "0" {
            enter()
            display.text = "\(x)"
            enter()
        } else {
            display.text = "\(x)"
            enter()
        }
    }

    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        display.text = "0.0"
        brain.performClear()
     }
    
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
        
    }

}

