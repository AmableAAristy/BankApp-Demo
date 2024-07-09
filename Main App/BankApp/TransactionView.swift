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
        
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    Text("Credit Card")
                        .font(.headline).bold()
                    Spacer()
                }//end Hstack (header)
                .padding(.horizontal, 20)
                
                // credit card image
                Image("creditCard4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 200)
                
                // Actions section
                HStack(spacing: 30) {
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                        
                        Text("Deposit")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "dollarsign")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }//end zstack
                        
                        Text("Pay")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }//end vstack
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "creditcard.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }//end ZStack
                        
                        Text("More")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }//end VStack
                }//end HStack
                .padding()
                
                Spacer()
                
                // ----------------------------------------------------
                
                // Add Transaction button
                NavigationLink(destination: TransactionInputView(company: $company, costString: $costString) { company, price in
                        addTransaction(company: company, price: price) {
                            fetchTransactions()
                    }
                }) {
                    Text("Add New Transaction")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                // -------------------------------------------------------
                
                // transactions list
                List{
                    Section(header: Text("Transactions")){
                        ForEach(transactions) { transaction in
                            HStack{
                                
                                Image(systemName: transaction.price <= 0.00 ? "arrow.down" : "arrow.up")
                                    .foregroundStyle(transaction.price <= 0.00 ? .red : .green)
                                
                                VStack(alignment: .leading){
                                    Text(Date().formatted())
                                        .foregroundStyle(.secondary)
                                        .font(.system(size: 12))
                                    Text(transaction.company)
                                        .font(.headline)
                                }
                            
                                Spacer()
                                
                                VStack(alignment: .leading){
                                    Text(String(format: "$%.2f", transaction.price))
                                        .foregroundColor(transaction.price <= 0.00 ? .red : .green)
                                }
                            }//end HStack
                        }//end ForEach
                    }//
                }//end List
                .listStyle(InsetGroupedListStyle())
                .padding()
                .onAppear(perform: fetchTransactions)
                
            }//end Vstack
        }//end Nav Stack
        
    }//end body
    
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
}//end TransactionView



#Preview {
    TransactionView()
}
