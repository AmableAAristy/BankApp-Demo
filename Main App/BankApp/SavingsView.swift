//
//  SavingsView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//

import SwiftUI

struct SavingsView: View {
    @StateObject private var viewModel = SavingsViewModel()
    @State private var description = ""
    @State private var amount: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Circular Progress Indicator
                    CircularProgressBar(progress: viewModel.progress)
                        .frame(width: 150, height: 150)
                        .padding(.top, 20)
                    
                    // Summary Section
                    VStack(spacing: 10) {
                        Text("Total Savings: $\(viewModel.totalSavings, specifier: "%.2f")")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Savings Goal: $\(viewModel.savingsGoal, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Remaining: $\(max(viewModel.savingsGoal - viewModel.totalSavings, 0), specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(viewModel.totalSavings >= viewModel.savingsGoal ? .green : .red)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                    // Add Savings Entry Section
                    VStack {
                        HStack {
                            TextField("Description", text: $description)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            
                            TextField("Amount", text: $amount)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            
                            Button(action: {
                                if let amountValue = Double(amount) {
                                    viewModel.addSavingsEntry(description: description, amount: amountValue)
                                    description = ""
                                    amount = ""
                                }
                            }) {
                                Text("Add")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Transactions")
                            .font(.headline)
                            .padding(.leading)
                        
                        ForEach(viewModel.savingsEntries) { entry in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(entry.description)
                                        .font(.headline)
                                    Text("$\(entry.amount, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Savings Tracker")
        }
    }
}

#Preview {
    SavingsView()
}
