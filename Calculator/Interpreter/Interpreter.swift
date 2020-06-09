//
//  Interpreter.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//


protocol ParserType {

    func parseExpression(_ input: String) throws -> [Instruction]
}

protocol VirtualMachineType {

    func execute(_ instructions: [InstructionType]) throws -> Double
}

protocol InstructionType {

    func execute(_ stack: inout [Double]) throws
}


/// Interpreter parses and evaluates instructions.
struct Interpreter {

    /// An error that can occur during evaluation.
    enum Error : Swift.Error {

        /// Syntax error in input. Reported by the parser.
        case syntax(_ error: Swift.Error)

        /// Runtime error during instruction execution.
        case runtime(_ error: RuntimeError)
    }

    let parser: ParserType

    let virtualMachine: VirtualMachineType

    init(parser: ParserType = ArithmeticParserWrapper(), virtualMachine: VirtualMachineType = VirtualMachine()) {
        self.parser = parser
        self.virtualMachine = virtualMachine
    }

    /// Evaluates the input string and returns resulting number or an error
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
