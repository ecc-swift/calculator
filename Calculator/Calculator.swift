//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Chun on 2019/9/30.
//  Copyright © 2019 NJU. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    
    enum Operation {
        case UnaryOp((Double) ->Double)
        case BinaryOp((Double, Double) -> Double)
        case EqualsOp
        case Constant(Double)
    }
    
    var operations  = [
        
        "+": Operation.BinaryOp({(op1, op2) in
            return op1+op2
        }),
        
        "−": Operation.BinaryOp({(op1: Double, op2: Double) -> Double in
            return op1-op2
        }),
        
        "×": Operation.BinaryOp({ $0 * $1 }),
        
        "÷": Operation.BinaryOp({ $0 / $1 }),
        
        "=": Operation.EqualsOp,
        
        "C": Operation.UnaryOp({_ in return 0}),
        
        "±": Operation.UnaryOp({ -$0}),
        
        "%": Operation.UnaryOp({ 0.01 * $0 }),
    ]
    
    
    func performOperation(operation: String, operand: Double)  -> Double? {
        if let op = operations[operation]{
            switch  op {
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waitingOperation: function)
                return nil
            case .UnaryOp(let function):
                return function(operand)
            case .EqualsOp:
                if let theOperation =  pendingOp{
                    return theOperation.waitingOperation(theOperation.firstOp, operand)
                }
            case .Constant(let value):
                return value
            }
        }
        return nil
    }
    
    var pendingOp: Intermediate? = nil
    
    
    struct Intermediate{
        var firstOp: Double
        var waitingOperation : (Double, Double) ->Double
    }
    

}
