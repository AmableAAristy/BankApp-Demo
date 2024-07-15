import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct StockView: View {
    @State private var stockName: String = ""
    @State private var suggestions: [String] = []
    @State private var stockTransactions: [StockTransaction] = []
    @State private var totalPrice: Double = 0.0
    private let trie = Trie()
    
    init() {
        let words = loadWords(from: "ticker")
        for word in words {
            trie.insert(word)
        }
    }
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
    var body: some View {
        VStack {
            VStack {
                TextField("Search for symbols!", text: Binding(get: {
                    self.stockName
                }, set: { newValue in
                    self.stockName = newValue.uppercased().filter { $0.isUppercase }
                    self.updateSuggestions()
                }))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: stockName) { newValue in
                    self.updateSuggestions()
                }
                .padding(.horizontal)
                
                if !suggestions.isEmpty {
                    List(suggestions, id: \.self) { suggestion in
                        Text(suggestion)
                            .onTapGesture {
                                stockName = suggestion
                                suggestions.removeAll()
                            }
                    }
                    .frame(height: 200)

                }
                   
            }
            
            Button(action: {
                           stockName = ""
                       }) {
                           NavigationLink(destination: SingleStockView(stockName: stockName)) {
                               Text("Search")
                           }
                       }
            
            if stockTransactions.isEmpty {
                Image("Stock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 550)
            } else {
                List {
                    ForEach(stockTransactions) { transaction in
                        VStack(alignment: .leading) {
                            Text("Company: \(transaction.company)")
                            Text("Purchase Date: \(transaction.purchaseDate)")
                            Text("Price: \(transaction.price, specifier: "%.2f")")
                        }
                        .padding()
                        .swipeActions {
                            Button(role: .destructive) {
                                if let id = transaction.id {
                                    deleteStockTransaction(id: id)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                Text("Total Price: \(totalPrice, specifier: "%.2f")")
                    .padding()
            }
        }
        .onAppear(perform: fetchStockTransactions)
    }
    
    private func updateSuggestions() {
        if stockName.isEmpty {
            suggestions.removeAll()
        } else {
            suggestions = trie.search(stockName)
        }
    }
    
    private func fetchStockTransactions() {
        db.collection("Accounts").document(userId).collection("Stocks").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting Stock: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.stockTransactions = documents.compactMap { doc -> StockTransaction? in
                return try? doc.data(as: StockTransaction.self)
            }
            
            //https://developer.apple.com/documentation/swift/array/reduce(_:_:)
            self.totalPrice = self.stockTransactions.reduce(0) { $0 + $1.price }
        }
    }
    
    private func deleteStockTransaction(id: String) {
        db.collection("Accounts").document(userId).collection("Stocks").document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
                // Remove the deleted transaction from the local list
                self.stockTransactions.removeAll { $0.id == id }
                // Update the total price
                self.totalPrice = self.stockTransactions.reduce(0) { $0 + $1.price }
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
