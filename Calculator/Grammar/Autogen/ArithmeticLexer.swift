// Generated from Arithmetic.g4 by ANTLR 4.7.1
import Antlr4

open class ArithmeticLexer: Lexer {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = ArithmeticLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(ArithmeticLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let NUMBER=1, PLUS=2, MINUS=3, MULT=4, DIV=5, WS=6

	public
	static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public
	static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public
	static let ruleNames: [String] = [
		"NUMBER", "PLUS", "MINUS", "MULT", "DIV", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, "'+'", "'-'", "'\u{00D7}'", "'\u{00F7}'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "NUMBER", "PLUS", "MINUS", "MULT", "DIV", "WS"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)


	override open
	func getVocabulary() -> Vocabulary {
		return ArithmeticLexer.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7.1", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, ArithmeticLexer._ATN, ArithmeticLexer._decisionToDFA, ArithmeticLexer._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "Arithmetic.g4" }

	override open
	func getRuleNames() -> [String] { return ArithmeticLexer.ruleNames }

	override open
	func getSerializedATN() -> String { return ArithmeticLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return ArithmeticLexer.channelNames }

	override open
	func getModeNames() -> [String] { return ArithmeticLexer.modeNames }

	override open
	func getATN() -> ATN { return ArithmeticLexer._ATN }


	public
	static let _serializedATN: String = ArithmeticLexerATN().jsonString

	public
	static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}