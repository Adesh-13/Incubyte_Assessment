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
    
    // Color scheme
    private let primaryColor = Color.blue
    private let secondaryColor = Color(UIColor.systemBackground)
    private let textColor = Color.primary
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [.white, .yellow, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("String Calculator")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .foregroundColor(.black)
                    
                    Text("Add numbers separated by commas")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .fontDesign(.monospaced)
                }
                .padding(.top, 32)
                
                // Input field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter Numbers")
                        .font(.title3)
                        .fontDesign(.monospaced)
                        .foregroundColor(.black)
                    
                    TextField("e.g., 1,2,3 or //;\n1;2;3", text: $inputString)
                        .textFieldStyle(ModernTextFieldStyle())
                        .submitLabel(.done)
                        .onSubmit {
                            viewModel.calculateSum(inputString: inputString)
                        }
                }
                .padding(.horizontal)
                
                // Calculate button
                Button(action: {
                    viewModel.calculateSum(inputString: inputString)
                }) {
                    HStack {
                        Image(systemName: "plus.square.fill")
                        Text("Calculate Sum")
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal)
                
                // Result display
                VStack(spacing: 8) {
                    Text("Result")
                        .font(.headline)
                        .fontDesign(.monospaced)
                        .foregroundColor(.black)
                    
                    Text(viewModel.result.isEmpty ? "0" : viewModel.result)
                        .font(.system(size: 42, weight: .bold, design: .monospaced))
                        .foregroundColor(primaryColor)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(secondaryColor)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        )
                }
                .padding()
                
                Spacer()
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    // Reset input on error dismissal
                    inputString = ""
                })
        }
        .animation(.easeInOut, value: viewModel.result)
    }
}

private struct ModernTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(Color(.white))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
            )
            .font(.system(.body, design: .monospaced))
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

private struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(14)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .shadow(color: .blue.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview {
    CalculatorView()
}

#Preview {
    CalculatorView()
}
