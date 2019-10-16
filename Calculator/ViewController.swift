//
//  ViewController.swift
//  Calculator
//
//  Created by Chun on 2019/9/30.
//  Copyright © 2019 NJU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var calculator = Calculator()
    
    var inTypingMiddle = false
    var doted = false
    
    var digitOnDisplay: String{
        get{
            return self.display.text!
        }
        set{
            self.display.text = newValue
        }
    }
    
    
    @IBAction func digitalButtonTouched(_ sender: UIButton){
        
        if let currentDigit = sender.currentTitle {
            if inTypingMiddle{
                if currentDigit == "." {
                    if doted {
                        return
                    }
                    doted = true
                }
                digitOnDisplay = digitOnDisplay + currentDigit
            }
            else{
                digitOnDisplay = currentDigit
                inTypingMiddle = true
                doted = false
            }
        }
    }
    
    @IBAction func operButtonTouched(_ sender: UIButton){
        
        if let op = sender.currentTitle {
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                digitOnDisplay = String(result)
            }
            
            inTypingMiddle = false
        }
    }

}

