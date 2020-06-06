//
//  Instruction.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//


/// The instruction executed by a virtual machine
enum Instruction {

    /// Load (push) numeric value onto the stack
    case load(_ number: Double)

    /// Perform arithmetic operation
    case arithmetic(_ operator: (Double, Double) -> Double)

    /// Negate the sign of a number
    case negate
}


extension Instruction : InstructionType {

    func execute(_ stack: inout [Double]) throws {
        switch self {
            case .load(let number):
                stack.append(number)

            case .arithmetic(let `operator`):
                guard stack.count > 1 else {
                    throw RuntimeError.generic
                }

                let arg1 = stack.removeLast()
                let arg2 = stack.removeLast()

                stack.append(`operator`(arg2, arg1))

            case .negate:
                guard !stack.isEmpty else {
                    throw RuntimeError.generic
                }

                let arg = stack.removeLast()
                stack.append(-arg)
        }
    }
}
