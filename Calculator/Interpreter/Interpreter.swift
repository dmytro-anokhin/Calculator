//
//  Interpreter.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import Antlr4


protocol ParserType {

    func parseExpression(_ input: String) throws -> [Instruction]
}

protocol VirtualMachineType {

    func execute(_ instructions: [InstructionType]) throws -> Double
}

protocol InstructionType {

    func execute(_ stack: inout [Double]) throws
}


struct Interpreter {

    enum Error : Swift.Error {

        case syntax(_ error: Swift.Error)

        case runtime(_ error: RuntimeError)
    }

    let parser: ParserType

    let virtualMachine: VirtualMachineType

    init(parser: ParserType, virtualMachine: VirtualMachineType) {
        self.parser = parser
        self.virtualMachine = virtualMachine
    }

    func evaluate(_ input: String) -> Result<Double, Error> {
        let instructions: [Instruction]

        do {
            instructions = try parser.parseExpression(input)
        }
        catch {
            return .failure(.syntax(error))
        }

        do {
            let resultValue = try virtualMachine.execute(instructions)
            return .success(resultValue)
        }
        catch {
            return .failure(.syntax(error))
        }
    }
}
