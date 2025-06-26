//
//  CalculatorModel.swift
//  Incubyte_Assessment
//
//  Created by Adesh Newaskar on 26/06/25.
//

import Foundation

enum CalculatorError: Error {
    case negativeNumbers(numbers: [Int])
    case invalidFormat
}

struct StringCalculator {
    static func add(_ numbers: String) throws -> Int {
        guard !numbers.isEmpty else {
            return 0
        }
        
        var delimiter = ","
        var numbersToProcess = numbers

        if numbers.hasPrefix("//") {
            if let newlineIndex = numbers.firstIndex(of: "\n") {
                let delimiterStart = numbers.index(numbers.startIndex, offsetBy: 2)
                delimiter = String(numbers[delimiterStart..<newlineIndex])
                numbersToProcess = String(numbers[numbers.index(after: newlineIndex)...])
            } else if let literalNewlineRange = numbers.range(of: "\\n") {
                let delimiterStart = numbers.index(numbers.startIndex, offsetBy: 2)
                delimiter = String(numbers[delimiterStart..<literalNewlineRange.lowerBound])
                numbersToProcess = String(numbers[literalNewlineRange.upperBound...])
            } else {
                throw CalculatorError.invalidFormat
            }
        }

        let normalizedInput = numbersToProcess
            .replacingOccurrences(of: "\n", with: delimiter)
            .replacingOccurrences(of: "\\n", with: delimiter)

        let numberStrings = normalizedInput.components(separatedBy: delimiter)
        
        var sum = 0
        var negativeNumbers = [Int]()

        for numStr in numberStrings where !numStr.isEmpty {
            guard let number = Int(numStr) else {
                throw CalculatorError.invalidFormat
            }

            if number < 0 {
                negativeNumbers.append(number)
            } else {
                sum += number
            }
        }

        if !negativeNumbers.isEmpty {
            throw CalculatorError.negativeNumbers(numbers: negativeNumbers)
        }

        return sum
    }
}

