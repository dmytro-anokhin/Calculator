//
//  ContentView.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 27/05/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import SwiftUI


struct ContentView: View {

    @ObservedObject
    private var keyboardStream: KeyboardStream = KeyboardStream()

    var body: some View {
        VStack(alignment: .trailing) {
            Text(keyboardStream.string)
                .frame(minHeight: 44.0)
                .font(Font.largeTitle)
                .foregroundColor(Color(white: 0.9))
            Spacer()
            Text(transform(keyboardStream.string))
                .frame(minHeight: 44.0)
                .font(Font.title)
                .foregroundColor(Color(white: 0.9))
            Spacer()
            KeyboardView(output: keyboardStream)
        }
        .padding(.all)
        .background(Color.purple)
    }

    private func transform(_ input: String) -> String {
        let interpreter = Interpreter()
        let result = interpreter.evaluate(input)

        switch result {
            case .success(let value):
                return "\(value)"
            case .failure:
                return ""
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
