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
    @Published var savingsGoal: Double = 10000.00 // Example goal
    
    var totalSavings: Double {
        savingsEntries.reduce(0) { $0 + $1.amount }
    }
    
    var progress: Double {
        totalSavings / savingsGoal
    }
    
    var groupedEntries: [Category: [SavingsEntry]] {
        Dictionary(grouping: savingsEntries, by: { $0.category })
    }

}
