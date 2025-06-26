//
//  CalculatorView.swift
//  Incubyte_Assessment
//
//  Created by Adesh Newaskar on 26/06/25.
//

import SwiftUI

struct CalculatorView: View {
    @State private var inputString = ""
    @State private var result = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("String Calculator")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter numbers (e.g., 1,2,3)", text: $inputString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Calculate Sum") {
                //Logic to be Implemented
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Text("Result: \(result)")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    CalculatorView()
}
