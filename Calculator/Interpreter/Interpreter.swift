//
//  Interpreter.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import Antlr4


final class Interpreter {

    enum Error : Swift.Error {

        case syntax(_ error: Swift.Error)

        case runtime(_ error: Swift.Error)
    }

    func evaluate(_ input: String) -> Result<Double, Error> {
        do {
            let instructions = try parseExpression(input)

            switch VirtualMachine().execute(instructions) {
                case .success(let value):
                    return .success(value)
                case .failure(let error):
                    return .failure(.runtime(error))
            }
        }
        catch {
            return .failure(.syntax(error))
        }
    }

    private final class Listener : ArithmeticBaseListener {

        private(set) var instructions: [Instruction] = []

        override func exitExpression(_ ctx: ArithmeticParser.ExpressionContext) {
            if ctx.MULT() != nil {
                // expression MULT expression
                instructions.append(.arithmetic(*))
            }
            else if ctx.DIV() != nil {
                // expression DIV expression
                instructions.append(.arithmetic(/))
            }
            else if ctx.PLUS(0) != nil {
                if ctx.number() == nil {
                    // expression PLUS expression
                    instructions.append(.arithmetic(+))
                }
                else {
                    // PLUS number
                    // Noop
                }
            }
            else if ctx.MINUS(0) != nil {
                if ctx.number() == nil {
                    // expression MINUS expression
                    instructions.append(.arithmetic(-))
                }
                else {
                    // MINUS number
                    instructions.append(.negate)
                }
            }
        }

        override func enterNumber(_ ctx: ArithmeticParser.NumberContext) {
            guard let number = Double(ctx.getText()) else {
                // This can happen when input is a + or - symbol without an actual number.
                return
            }

            instructions.append(.load(number))
        }
    }

    private func parseExpression(_ input: String) throws -> [Instruction] {
        let parser = try buildParser(input)
        let expressionContext = try parser.expression()

        let listener = Listener()
        try ParseTreeWalker().walk(listener, expressionContext)

        return listener.instructions
    }

    private func buildParser(_ input: String) throws -> ArithmeticParser {
        let inputStream = ANTLRInputStream(input)
        let lexer = ArithmeticLexer(inputStream)
        let tokenStream = CommonTokenStream(lexer)

        return try ArithmeticParser(tokenStream)
    }
}