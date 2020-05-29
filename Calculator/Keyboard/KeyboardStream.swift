//
//  KeyboardStream.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 28/05/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import Combine


final class KeyboardStream : KeyboardOutput, ObservableObject {

    private(set) var characters: [Character] = [] {
        willSet {
            objectWillChange.send()
        }
    }

    var string: String {
        String(characters)
    }

    func append(_ character: Character) {
        characters.append(character)
    }

    func delete() {
        guard !characters.isEmpty else { return }
        characters.removeLast()
    }

    func clear() {
        guard !characters.isEmpty else { return }
        characters = []
    }
}
