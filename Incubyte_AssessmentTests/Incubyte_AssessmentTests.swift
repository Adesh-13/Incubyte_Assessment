//
//  Incubyte_AssessmentTests.swift
//  Incubyte_AssessmentTests
//
//  Created by Adesh Newaskar on 26/06/25.
//

import Testing
@testable import Incubyte_Assessment
import XCTest

class StringCalculatorTests: XCTestCase {
    //Created an Extension
}

class CalculatorViewModelTests: XCTestCase {
    var viewModel: CalculatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testEmptyInputShouldReturnZero() {
        viewModel.calculateSum(inputString: "")
        XCTAssertEqual(viewModel.result, "0")
        XCTAssertFalse(viewModel.showingAlert)
    }

    func testSimpleCommaSeparatedInput() {
        viewModel.calculateSum(inputString: "1,2,3")
        XCTAssertEqual(viewModel.result, "6")
        XCTAssertFalse(viewModel.showingAlert)
    }

    func testNewlineAsDelimiter() {
        viewModel.calculateSum(inputString: "1\n2,3")
        XCTAssertEqual(viewModel.result, "6")
        XCTAssertFalse(viewModel.showingAlert)
    }

    func testCustomDelimiter() {
        viewModel.calculateSum(inputString: "//;\n1;2")
        XCTAssertEqual(viewModel.result, "3")
        XCTAssertFalse(viewModel.showingAlert)
    }

    func testNegativeNumberShowsAlert() {
        viewModel.calculateSum(inputString: "1,-2,3,-5")
        XCTAssertEqual(viewModel.result, "Error")
        XCTAssertTrue(viewModel.showingAlert)
        XCTAssertEqual(viewModel.alertMessage, "Negative numbers not allowed -2,-5")
    }

    func testInvalidInputFormat() {
        viewModel.calculateSum(inputString: "1,\n")
        XCTAssertEqual(viewModel.result, "1")
        XCTAssertFalse(viewModel.showingAlert)
    }
}

// MARK: - StringCalculator Model Tests
extension StringCalculatorTests {
    // Test empty string
    func testEmptyStringReturnsZero() throws {
        XCTAssertEqual(try StringCalculator.add(""), 0)
    }
    
    // Test single number
    func testSingleNumberReturnsValue() throws {
        XCTAssertEqual(try StringCalculator.add("1"), 1)
        XCTAssertEqual(try StringCalculator.add("5"), 5)
        XCTAssertEqual(try StringCalculator.add("10"), 10)
    }
    
    // Test two numbers
    func testTwoNumbersCommaDelimitedReturnsSum() throws {
        XCTAssertEqual(try StringCalculator.add("1,5"), 6)
        XCTAssertEqual(try StringCalculator.add("10,20"), 30)
    }
    
    // Test multiple numbers
    func testMultipleNumbersCommaDelimitedReturnsSum() throws {
        XCTAssertEqual(try StringCalculator.add("1,2,3,4,5"), 15)
    }
    
    // Test newline delimiter
    func testNewlineBetweenNumbersReturnsSum() throws {
        XCTAssertEqual(try StringCalculator.add("1\n2,3"), 6)
        XCTAssertEqual(try StringCalculator.add("1\n2\n3"), 6)
    }
    
    // Test custom delimiter
    func testCustomDelimiterReturnsSum() throws {
        XCTAssertEqual(try StringCalculator.add("//;\n1;2"), 3)
        XCTAssertEqual(try StringCalculator.add("//|\n1|2|3"), 6)
        XCTAssertEqual(try StringCalculator.add("//sep\n1sep2sep3"), 6)
    }
    
    // Test literal \n delimiter
    func testLiteralNewlineDelimiterReturnsSum() throws {
        XCTAssertEqual(try StringCalculator.add("//;\\n1;2"), 3)
        XCTAssertEqual(try StringCalculator.add("1\\n2,3"), 6)
    }
    
    // Test negative numbers
    func testNegativeNumbersThrowsError() {
        do {
            _ = try StringCalculator.add("1,-2,3,-4")
            XCTFail("Should have thrown exception")
        } catch CalculatorError.negativeNumbers(let numbers) {
            XCTAssertEqual(numbers, [-2, -4])
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // Test invalid format
    func testInvalidFormatThrowsError() {
        
        // Invalid number format
        XCTAssertThrowsError(try StringCalculator.add("1,a,3")) { error in
            XCTAssertTrue(error is CalculatorError)
        }
        
        // Missing newline after delimiter
        XCTAssertThrowsError(try StringCalculator.add("//;1;2")) { error in
            XCTAssertTrue(error is CalculatorError)
        }
    }
    
    // Test large numbers
    func testLargeNumbersAreHandled() throws {
        XCTAssertEqual(try StringCalculator.add("1000,2000,3000"), 6000)
        XCTAssertEqual(try StringCalculator.add("999,999,999"), 2997)
    }
    
    // Test empty entries
    func testEmptyEntriesAreIgnored() throws {
        XCTAssertEqual(try StringCalculator.add("1,,2"), 3)
        XCTAssertEqual(try StringCalculator.add("1,\n,2"), 3)
    }
}
