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
    @State private var selectedCategory: Category = .other
    
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
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Transactions")
                            .font(.headline)
                            .padding(.leading)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Description")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                TextField("Description", text: $description)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(10)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Amount")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                TextField("Amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(10)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Category")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(Category.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            if let amountValue = Double(amount) {
                                viewModel.addSavingsEntry(description: description, amount: amountValue, category: selectedCategory)
                                description = ""
                                amount = ""
                            }
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                    // Recent Transactions by Category
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Category.allCases) { category in
                            if let entries = viewModel.groupedEntries[category], !entries.isEmpty {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(category.rawValue)
                                        .font(.headline)
                                        .padding(.leading)
                                    
                                    ForEach(entries) { entry in
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
                        }
                    }
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
