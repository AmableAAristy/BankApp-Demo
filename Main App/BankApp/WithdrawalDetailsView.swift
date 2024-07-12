//
//  WithdrawalDetailsView.swift
//  BankApp
//
//  Created by ethan b on 7/9/24.
//

import Foundation
import SwiftUI

struct WithdrawalDetailsView: View {
    var body: some View {
        List {
            Section(header: Text("Recent Withdrawals")) {
                WithdrawalRow(date: "July 1, 2024", amount: "$200", method: "ATM", status: "Completed")
                WithdrawalRow(date: "June 25, 2024", amount: "$500", method: "Bank Transfer", status: "Completed")
                WithdrawalRow(date: "June 15, 2024", amount: "$300", method: "ATM", status: "Pending")
            }
            
            Section(header: Text("Withdrawal Limits")) {
                VStack(alignment: .leading) {
                    Text("Daily Limit: $1,000")
                    Text("Weekly Limit: $5,000")
                    Text("Monthly Limit: $20,000")
                    Button(action: {
                        // Action to change withdrawal limits
                    }) {
                        Text("Set/Change Limits")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 10)
            }
            
            Section(header: Text("Withdrawal Methods")) {
                VStack(alignment: .leading) {
                    Text("1. ATM Withdrawal")
                    Text("2. Bank Transfer")
                    Text("3. Cash Pickup")
                }
                .padding(.vertical, 10)
            }
            
            Section(header: Text("Search and Filter")) {
                VStack(alignment: .leading) {
                    Text("Use the tools below to search for specific withdrawals or filter by date, amount, or method.")
                    Button(action: {
                        // Action to open search and filter tools
                    }) {
                        Text("Search and Filter")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 10)
            }
            
            Section(header: Text("Support and Help")) {
                VStack(alignment: .leading) {
                    Text("If you have any issues with withdrawals, please contact our support team.")
                    Button(action: {
                        // Action to contact support
                    }) {
                        Text("Contact Support")
                            .foregroundColor(.blue)
                    }
                    Text("FAQs related to withdrawals can be found here.")
                }
                .padding(.vertical, 10)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Withdrawal Details", displayMode: .inline)
    }
}

struct WithdrawalRow: View {
    let date: String
    let amount: String
    let method: String
    let status: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Amount: \(amount)")
                    .font(.headline)
                Text("Method: \(method)")
                    .font(.subheadline)
                Text("Status: \(status)")
                    .font(.subheadline)
                    .foregroundColor(status == "Pending" ? .orange : .green)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    WithdrawalDetailsView()
}
