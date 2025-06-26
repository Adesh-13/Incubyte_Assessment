//
//  CalculatorViewModel.swift
//  Incubyte_Assessment
//
//  Created by Adesh Newaskar on 26/06/25.
//

import Foundation
import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var inputString: String = ""
    @Published var result: String = ""
    @Published var alertMessage: String = ""
    @Published var showingAlert: Bool = false

    func calculateSum(inputString: String) {
        do {
            let sum = try StringCalculator.add(inputString)
            result = "\(sum)"
        } catch CalculatorError.negativeNumbers(let numbers) {
            alertMessage = "Negative numbers not allowed " + numbers.map(String.init).joined(separator: ",")
            showingAlert = true
            result = "Error"
        } catch {
            alertMessage = "An unexpected error occurred"
            showingAlert = true
            result = "Error"
        }
    }
}
