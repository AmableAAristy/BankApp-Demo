//
//  FireBase.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

struct Transaction: Codable, Identifiable{
    @DocumentID var id: String? = UUID().uuidString
    
    let company: String
    let price: Double
    var timestamp: Timestamp? = Timestamp(date: Date())
}

struct PersonalDetails: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    let name: String
    let dob: String
    let address: String
    let phone: String //can change this to Int
    let email: String
    var timestamp: Timestamp? = Timestamp(date: Date())
}

struct StockTransaction: Identifiable, Codable, Hashable{
    @DocumentID var id: String? = UUID().uuidString
    let company: String
    let purchaseDate: String
    let price:Double
    var timestamp: Timestamp? = Timestamp(date: Date())
}

struct SavingsEntry: Codable, Identifiable {
    var id = UUID()
    let description: String
    let amount: Double
    let category: Category
    var timestamp: Timestamp? = Timestamp(date: Date())

}

// Define categories for savings entries
enum Category: String, CaseIterable, Identifiable, Codable {
    case foodAndRestaurants = "Food & Restaurants"
    case entertainment = "Entertainment"
    case utilities = "Utilities"
    case transportation = "Transportation"
    case shopping = "Shopping"
    case other = "Other"
    
    var id: String { self.rawValue }
}



