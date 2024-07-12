//
//  TransactionInputView.swift
//  BankApp
//
//  Created by Angie Martinez on 7/8/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct TransactionInputView: View {
    @Binding var company: String
    @Binding var costString: String
    var addTransaction: (String, Double) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    let userId = Auth.auth().currentUser?.uid ?? "3445"
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            TextField("Who did you do the transaction with?", text: $company)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("For how much?", text: $costString)
                .keyboardType(.decimalPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                if let cost = Double(costString) {
                    addTransaction(company, cost)
                    // Clear the input fields
                    company = ""
                    costString = ""
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Submit Amount")
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    @State var company = ""
    @State var costString = ""
    return VStack {
        TransactionInputView(company: $company, costString: $costString) { company, price in
            // Sample addTransaction function for preview
            print("Adding transaction with company: \(company), price: \(price)")
        }
    }
}

