//
//  KeyboardView.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 27/05/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import SwiftUI


enum KeyboardButton : Hashable {

    enum Action : Hashable {

        case delete

        case clear

        fileprivate var label: String {
            switch self {
                case .delete:
                    return "Delete"
                case .clear:
                    return "Clear"
            }
        }

        fileprivate func execute(_ output: KeyboardOutput) {
            switch self {
                case .delete:
                    output.delete()
                case .clear:
                    output.clear()
            }
        }
    }

    case digit(_ character: Character)

    case arithmetic(_ character: Character)

    case action(_ action: Action)

    case placeholder
}


fileprivate extension KeyboardButton {

    func execute(_ output: KeyboardOutput) {
        switch self {
            case .digit(let character):
                output.append(character)
            case .arithmetic(let character):
                output.append(character)
            case .action(let action):
                action.execute(output)
            case .placeholder:
                preconditionFailure("Placeholder can not be executed")
        }
    }
}


fileprivate extension KeyboardButton {

    var label: String {
        switch self {
            case .digit(let character):
                return String(character)
            case .arithmetic(let character):
                return String(character)
            case .action(let action):
                return action.label
            case .placeholder:
                preconditionFailure("Placeholder has no label")
        }
    }

    var foregroundColor: Color {
        switch self {
            case .digit:
                return Color(white: 0.1)
            case .arithmetic:
                return Color(white: 0.1)
            case .action:
                return Color(white: 0.9)
            case .placeholder:
                return Color.clear
        }
    }

    var backgroundColor: Color {
        switch self {
            case .digit:
                return Color.yellow
            case .arithmetic:
                return Color.orange
            case .action:
                return Color.blue
            case .placeholder:
                return Color.clear
        }
    }

    var font: Font {
        switch self {
            case .digit:
                return Font.title
            case .arithmetic:
                return Font.title
            case .action:
                return Font.headline
            case .placeholder:
                preconditionFailure("Placeholder has no font")
        }
    }

    var heightMultiplier: CGFloat {
        switch self {
            case .action:
                return 0.25
            default:
                return 1.0
        }
    }
}


protocol KeyboardOutput {

    func append(_ character: Character)

    func delete()

    func clear()
}


struct KeyboardView: View {

    private let actionButtons: [[KeyboardButton]] = [
        [ .action(.delete), .action(.clear) ]
    ]

    private let inputButtons: [[KeyboardButton]] = [
        [ .digit("9"), .digit("8"), .digit("7"), .arithmetic("÷") ],
        [ .digit("6"), .digit("5"), .digit("4"), .arithmetic("×") ],
        [ .digit("3"), .digit("2"), .digit("1"), .arithmetic("-") ],
        [ .placeholder, .digit("0"), .placeholder, .arithmetic("+") ]
    ]

    private var output: KeyboardOutput

    init(output: KeyboardOutput) {
        self.output = output
    }

    var body: some View {
        VStack {
            makeGrid(buttons: actionButtons).frame(height: 44.0)
            makeGrid(buttons: inputButtons)
        }
    }

    private func makeGrid(buttons: [[KeyboardButton]]) -> some View {
        Grid(data: buttons) { button in
            KeyboardButtonView(button) {
                button.execute(self.output)
            }
            .background(button.backgroundColor)
        }
    }
}


fileprivate struct KeyboardButtonView: View {

    let button: KeyboardButton

    let action: () -> Void

    init(_ button: KeyboardButton, _ action: @escaping () -> Void) {
        self.button = button
        self.action = action
    }

    var body: some View {
        Button(action: {
            guard self.button != .placeholder else { return }
            self.action()
        }) {
            GeometryReader { geometry in
                Group {
                    if self.button == .placeholder {
                        EmptyView()
                    }
                    else {
                        Text(self.button.label)
                            .font(self.button.font)
                            .foregroundColor(self.button.foregroundColor)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}


struct KeyboardView_Previews: PreviewProvider {

    private struct DummyOutput : KeyboardOutput {

        func append(_ character: Character) { }

        func delete() { }

        func clear() { }
    }

    static var previews: some View {
        KeyboardView(output: DummyOutput())
    }
}
