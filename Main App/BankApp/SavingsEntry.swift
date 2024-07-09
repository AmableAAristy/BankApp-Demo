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
    let category: Category
}

// Define categories for savings entries
enum Category: String, CaseIterable, Identifiable {
    case foodAndRestaurants = "Food & Restaurants"
    case entertainment = "Entertainment"
    case utilities = "Utilities"
    case transportation = "Transportation"
    case shopping = "Shopping"
    case other = "Other"
    
    var id: String { self.rawValue }
}

