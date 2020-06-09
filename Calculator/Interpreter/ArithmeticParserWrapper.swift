//
//  ArithmeticParserWrapper.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 05/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import Antlr4


/// Wrapper (adapter) around Antlr4 library.
struct ArithmeticParserWrapper : ParserType {

    /// Convers AST nodes to instructions.
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
                    // PLUS number - noop
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
                // This happens when the token is a '+' or '-' symbol without an actual number.
                return
            }

            instructions.append(.load(number))
        }
    }

    func parseExpression(_ input: String) throws -> [Instruction] {
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
