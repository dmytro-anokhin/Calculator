//
//  Instruction.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//


/// The instruction executed by a virtual machine
enum Instruction {

    /// Load numeric value on stack
    case load(_ number: Double)

    /// Perform arithmetic operation
    case arithmetic(_ operator: (Double, Double) -> Double)

    /// Set number as negative, used with - sign
    case negate
}
