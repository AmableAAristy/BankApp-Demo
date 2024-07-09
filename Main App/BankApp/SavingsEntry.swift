//
//  SavingsEntry.swift
//  BankApp
//
//  Created by Angie Martinez on 7/8/24.
//

import Foundation

// Define a model to represent a savings entry
struct SavingsEntry: Identifiable {
    let id = UUID()
    let description: String
    let amount: Double
}
