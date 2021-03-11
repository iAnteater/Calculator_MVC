//
//  CalculatprBrain.swift
//  Calculator
//
//  Created by Osadchuk Taras on 28.11.2020.
//  Copyright © 2020 Osadchuk Taras. All rights reserved.
//

import Foundation

class CalculatorBrain {
    var accumulator = 0.0
    func setOperand(operand:Double) {
        accumulator = operand
    }
    
    enum Operation {
        case Constant (Double)
        case UnaryOperation ((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    var Operations: Dictionary <String, Operation> = [
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
        
    ]
    
    var pending: pendingBinaryOperation?
    
    struct pendingBinaryOperation {
        var binaryOperation: (Double,Double) -> Double
        var firstOperand: Double
    }
    var result:Double{
        get{
            return accumulator}
    }
    
    func performOperation(symbol:String) {
        if let operation = Operations [symbol]{
            switch operation {
            case .Constant (let value): accumulator = value
            case .UnaryOperation(let function) : accumulator = function(accumulator)
            case .BinaryOperation(let function): pending = pendingBinaryOperation(binaryOperation: function, firstOperand: accumulator)
            case .Equals:
                if pending != nil{
                    accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator )
                    pending = nil
                }
            
            }
        }
       
    }
    
}
