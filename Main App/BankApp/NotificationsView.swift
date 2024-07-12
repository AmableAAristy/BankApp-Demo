//
//  NotificationsView.swift
//  BankApp
//
//  Created by ethan b on 7/9/24.
//

import Foundation
import SwiftUI

struct NotificationsView: View {
    var body: some View {
        List {
            Section(header: Text("Transactions")) {
                NotificationRow(icon: "dollarsign.circle.fill", title: "Transaction Successful", message: "You received $500.")
                NotificationRow(icon: "exclamationmark.triangle.fill", title: "Transaction Failed", message: "Your transfer of $200 failed.")
                NotificationRow(icon: "creditcard.fill", title: "Large Transaction Alert", message: "A withdrawal of $1000 was made.")
            }
            
            Section(header: Text("Account Alerts")) {
                NotificationRow(icon: "banknote.fill", title: "Low Balance Alert", message: "Your balance is below $50.")
                NotificationRow(icon: "chart.bar.fill", title: "Weekly Balance Summary", message: "Your balance is $1500.")
            }
            
            Section(header: Text("Security")) {
                NotificationRow(icon: "lock.shield.fill", title: "New Login Detected", message: "A login from a new device was detected.")
                NotificationRow(icon: "key.fill", title: "Password Changed", message: "Your password was successfully changed.")
            }
            
            Section(header: Text("Bill Payments")) {
                NotificationRow(icon: "calendar.badge.clock", title: "Bill Due Reminder", message: "Your electricity bill is due tomorrow.")
                NotificationRow(icon: "checkmark.circle.fill", title: "Bill Payment Successful", message: "Your phone bill was paid.")
            }
            
            Section(header: Text("Promotions")) {
                NotificationRow(icon: "tag.fill", title: "Special Offer", message: "Get a 3% cashback on your next purchase.")
                NotificationRow(icon: "percent", title: "Interest Rate Change", message: "Interest rates have changed to 1.5%.")
            }
            
            Section(header: Text("System Maintenance")) {
                NotificationRow(icon: "wrench.fill", title: "Scheduled Maintenance", message: "Scheduled maintenance on July 15, 2:00 AM - 4:00 AM.")
                NotificationRow(icon: "exclamationmark.triangle.fill", title: "Unscheduled Downtime", message: "We are currently experiencing downtime.")
            }
            
            Section(header: Text("Fraud Alerts")) {
                NotificationRow(icon: "exclamationmark.shield.fill", title: "Suspicious Activity Detected", message: "Please review your recent transactions.")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Notifications", displayMode: .inline)
    }
}

struct NotificationRow: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    NotificationsView()
}
