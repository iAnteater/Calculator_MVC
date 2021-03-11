//
//  ViewController.swift
//  Calculator
//
//  Created by Osadchuk Taras on 05.07.2020.
//  Copyright © 2020 Osadchuk Taras. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var brain = CalculatorBrain()
    var InTheMiddleOfTyping: Bool = false
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var displayValue: Double {
        get{
            let stringValue = displayLabel.text!.replacingOccurrences(of: ",", with: ".")
            return Double(stringValue)!
        }
        set{
            displayLabel.text = String (newValue).replacingOccurrences(of: ",", with: ".")
        }
    }
    
    @IBAction func didgitButtonTapped(_ sender: UIButton) {
        let didgit = sender.currentTitle
        let display = displayLabel!.text
        if InTheMiddleOfTyping{
        displayLabel.text = display! + didgit!
        }else{
            displayLabel.text = didgit
            InTheMiddleOfTyping = true
        }
        
    }
    @IBAction func clearButton(_ sender: UIButton) {
        displayValue = 0
        displayLabel.text = "0"
    }
    @IBAction func calculatorButton(_ sender: UIButton) {
        if InTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            InTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation( symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

