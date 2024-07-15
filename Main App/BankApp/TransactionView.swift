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
    
    @State private var transactions: [Transaction] = []
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
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
                NavigationLink(destination: TransactionInputView()
                ) {
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
    


    func fetchTransactions() {
        
        db.collection("Accounts").document(userId).collection("Credit").order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting Credit: \(error)")
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
