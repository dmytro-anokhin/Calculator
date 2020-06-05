// Generated from Arithmetic.g4 by ANTLR 4.7.1
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ArithmeticParser}.
 */
public protocol ArithmeticListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ArithmeticParser#root}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterRoot(_ ctx: ArithmeticParser.RootContext)
	/**
	 * Exit a parse tree produced by {@link ArithmeticParser#root}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitRoot(_ ctx: ArithmeticParser.RootContext)
	/**
	 * Enter a parse tree produced by {@link ArithmeticParser#expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterExpression(_ ctx: ArithmeticParser.ExpressionContext)
	/**
	 * Exit a parse tree produced by {@link ArithmeticParser#expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitExpression(_ ctx: ArithmeticParser.ExpressionContext)
	/**
	 * Enter a parse tree produced by {@link ArithmeticParser#number}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNumber(_ ctx: ArithmeticParser.NumberContext)
	/**
	 * Exit a parse tree produced by {@link ArithmeticParser#number}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNumber(_ ctx: ArithmeticParser.NumberContext)
}