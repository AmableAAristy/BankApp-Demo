//
//  MyCardsView.swift
//  BankApp
//
//  Created by ethan b on 7/9/24.
//

import SwiftUI

import Foundation
import SwiftUI

struct MyCardsView: View {
    var body: some View {
        List {
            Section(header: Text("Credit Card")) {
                CardView(
                    cardType: "Credit Card",
                    bankName: "Bank of America",
                    cardNumber: "**** **** **** 1234",
                    expiryDate: "12/25",
                    cardHolder: "John Samuel Smith"
                )
            }
            Section(header: Text("Debit Card")) {
                CardView(
                    cardType: "Debit Card",
                    bankName: "Bank of America",
                    cardNumber: "**** **** **** 5678",
                    expiryDate: "08/24",
                    cardHolder: "John Samuel Smith"
                )
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("My Cards", displayMode: .inline)
    }
}

struct CardView: View {
    let cardType: String
    let bankName: String
    let cardNumber: String
    let expiryDate: String
    let cardHolder: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(bankName)
                .font(.headline)
                .padding(.bottom, 5)
            Text(cardType)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
            Text(cardNumber)
                .font(.title2)
                .padding(.bottom, 5)
            HStack {
                Text("Expiry Date:")
                    .font(.subheadline)
                Text(expiryDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Card Holder:")
                    .font(.subheadline)
                Text(cardHolder)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    MyCardsView()
}
