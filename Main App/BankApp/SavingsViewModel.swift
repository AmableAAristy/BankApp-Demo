import Foundation
import Firebase
import FirebaseFirestoreSwift

// ViewModel to manage the savings data
class SavingsViewModel: ObservableObject {
    @Published var savingsEntries: [SavingsEntry] = []
    @Published var savingsGoal: Double = 10000.00 // Example goal
    
    private let db = Firestore.firestore()
    private let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
    var totalSavings: Double {
        savingsEntries.reduce(0) { $0 + $1.amount }
    }
    
    var progress: Double {
        totalSavings / savingsGoal
    }
    
    var groupedEntries: [Category: [SavingsEntry]] {
        Dictionary(grouping: savingsEntries, by: { $0.category })
    }
    
    func addSavingsEntry(description: String, amount: Double, category: Category) {
        let newSavings = SavingsEntry(description: description, amount: amount, category: category, timestamp: Timestamp(date: Date()))
        
        do {
            let _ = try db.collection("Accounts").document(userId).collection("Savings").addDocument(from: newSavings) { error in
                if let error = error {
                    print("Error writing transaction to Firestore: \(error)")
                } else {
                    self.fetchSavingsEntries()
                }
            }
        } catch let error {
            print("Error writing transaction to Firestore: \(error)")
        }
    }
    
    func fetchSavingsEntries() {
        db.collection("Accounts").document(userId).collection("Savings").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting Savings: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.savingsEntries = documents.compactMap { doc -> SavingsEntry? in
                return try? doc.data(as: SavingsEntry.self)
            }
        }
    }
}
