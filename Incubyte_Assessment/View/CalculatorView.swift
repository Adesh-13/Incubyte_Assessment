//
//  CalculatorView.swift
//  Incubyte_Assessment
//
//  Created by Adesh Newaskar on 26/06/25.
//

import SwiftUI

struct CalculatorView: View {
    @State private var inputString = ""
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("String Calculator")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter numbers (e.g., 1,2,3)", text: $inputString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Calculate Sum") {
                viewModel.calculateSum(inputString: inputString)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Text("Result: \(viewModel.result)")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    CalculatorView()
}
