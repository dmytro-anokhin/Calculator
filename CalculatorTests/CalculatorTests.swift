//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Dmytro Anokhin on 27/05/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.
//

import XCTest
@testable import Calculator


class CalculatorTests: XCTestCase {

    func testSuccess() throws {
        let samples: [(String, Double)] = [
            ("40 + 2", 42.0),
            ("2 + 4 × 10", 42.0)
        ]

        for sample in samples {
            let interpreter = Interpreter(parser: ArithmeticParserWrapper(), virtualMachine: VirtualMachine())

            switch interpreter.evaluate(sample.0) {
                case .success(let value):
                    XCTAssertEqual(value, sample.1)
                case .failure(let error):
                    XCTFail("Error evaluating expression '\(sample.0)': expected: \(sample.1); got: \(error)")
            }
        }
    }
}
