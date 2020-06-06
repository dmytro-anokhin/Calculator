//
//  VirtualMachine.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

struct VirtualMachine : VirtualMachineType {

    func execute(_ instructions: [InstructionType]) throws -> Double {
        var stack: [Double] = []

        for instruction in instructions {
            try instruction.execute(&stack)
        }

        guard let resultValue = stack.last else {
            throw RuntimeError.generic
        }

        return resultValue
    }
}
