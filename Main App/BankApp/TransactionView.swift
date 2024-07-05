//
//  CreditView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct TransactionView: View {
    @State var company: String = ""
    @State var costString: String = ""
    @State private var transactions: [Transaction] = []
    var cost: Double {
        get {
            Double(costString) ?? 0.00
        }
        set {
            costString = String(newValue)
        }
    }
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack{
            
            TextField("Who did you do the transaction with?", text: $company)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("For how much?", text: $costString)
                .keyboardType(.decimalPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                addTransaction(company: company, price: cost){
                    // Clear the input fields
                    company = ""
                    costString = ""
                    fetchTransactions()
                }
            }) {
                Text("Submit to database")
            }
            .padding()
            List(transactions) { transaction in
                HStack {
                    Text(transaction.company)
                    Spacer()
                    Text(String(format: "$%.2f", transaction.price))
                        .foregroundColor(transaction.price <= 0.00 ? .red : .green)
                }
            }
            .padding()
            .onAppear(perform: fetchTransactions)
        }
    }//end Vstack
    
    func addTransaction(company: String, price: Double, completion: @escaping () -> Void) {
        
        let newTransaction = Transaction(company: company, price: price)
        
        do {
            let _ = try db.collection("transactions").addDocument(from: newTransaction) { error in
                if let error = error {
                    print("Error writing transaction to Firestore: \(error)")
                } else {
                    //makes this an async, so app knows to pull after it is succeesfuly put in db
                    completion()
                }
            }
        } catch let error {
            print("Error writing transaction to Firestore: \(error)")
        }
    }//end add
    func fetchTransactions() {
        
        db.collection("transactions").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting transactions: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.transactions = documents.compactMap { (doc) -> Transaction? in
                return try? doc.data(as: Transaction.self)
            }
        }
    }//end fetch
}



#Preview {
    TransactionView()
}
