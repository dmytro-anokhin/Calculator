# Calculator

This is a sample iOS app that uses [ANTLR v4](https://github.com/antlr/antlr4) to parse input text and evaluate arithmetic expressions. Like this:

```swift
let interpreter = Interpreter()
let result = interpreter.evaluate("2 + 4 × 10")

switch result {
    case .success(let value):
        print(value)
    case .failure(let error):
        print(error)        
}
```
```
42.0
```

And the app is in SwiftUI :) 
