//
//  SavingsViewModel.swift
//  BankApp
//
//  Created by Angie Martinez on 7/8/24.
//

import Foundation

// ViewModel to manage the savings data
class SavingsViewModel: ObservableObject {
    @Published var savingsEntries: [SavingsEntry] = []
    @Published var savingsGoal: Double = 1000.0 // Example goal
    
    var totalSavings: Double {
        savingsEntries.reduce(0) { $0 + $1.amount }
    }
    
    var progress: Double {
        totalSavings / savingsGoal
    }
    
    func addSavingsEntry(description: String, amount: Double) {
        let newEntry = SavingsEntry(description: description, amount: amount)
        savingsEntries.append(newEntry)
    }
}
