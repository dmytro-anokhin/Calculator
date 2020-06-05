//
//  VirtualMachine.swift
//  Calculator
//
//  Created by Dmytro Anokhin on 03/06/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//


struct VirtualMachine {

    typealias Result = Swift.Result<Double, Error>

    enum Error : Swift.Error {

        case generic
    }

    func execute(_ instructions: [Instruction]) -> Result {
        var stack: [Double] = []

        for instruction in instructions {
            switch instruction {
                case .load(let number):
                    stack.append(number)

                case .arithmetic(let `operator`):
                    guard stack.count > 1 else {
                        return .failure(.generic)
                    }

                    let arg1 = stack.removeLast()
                    let arg2 = stack.removeLast()

                    stack.append(`operator`(arg2, arg1))

                case .negate:
                    guard !stack.isEmpty else {
                        return .failure(.generic)
                    }

                    let arg = stack.removeLast()
                    stack.append(-arg)
            }
        }

        guard let resultValue = stack.last else {
            return .failure(.generic)
        }

        return .success(resultValue)
    }
}
