import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct HomeView: View {
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
    @State var accountBalance: Double = 0.00
    @State var savingsBalance: Double = 0.00
    @State var creditBalance: Double = 0.00
    @State var stocksBalance: Double = 0.00
    @State var userName: String = "John Doe"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Header
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.trailing, 10)
                        
                        Text("Welcome \(userName)!")
                            .font(.title2).bold()
                            
                        
                        Spacer()
                        
                        HStack(spacing: 30) {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            
                            Image(systemName: "gear")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Spacer().frame(height: 30)
                    
                    Text("Account Balance")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                        .padding(.top, 15)
                    
                    // Account balance section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("$\(accountBalance, specifier: "%.2f")")
                                .font(.largeTitle).bold()
                                .padding(-15)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 30)
                    
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
                            
                            Text("Withdraw")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 48, height: 48)
                                
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                            
                            Text("Transfer")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
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
                            }
                            
                            Text("Deposit")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding()
                    
                    // Rectangles with arrows section
                    VStack(spacing: 20) {
                        NavigationLink(destination: SavingsView()) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Savings")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("$\(savingsBalance, specifier: "%.2f")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: TransactionView()) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Credit")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("$\(creditBalance, specifier: "%.2f")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: StockView()) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Stocks")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text("$\(stocksBalance, specifier: "%.2f")")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                fetchAll()
            }
        }
    }
    
    private func fetchAll() {
        fetchProfileInfo()
        fetchStocksBalance()
        fetchCreditBalance()
        fetchSavingsBalance()
        // Update account balance after fetching all individual balances
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.accountBalance = self.savingsBalance + self.creditBalance + self.stocksBalance + self.creditBalance
        }
    }
    
    private func fetchProfileInfo() {
        db.collection("Accounts").document(userId).collection("UserInfo").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting User Info: \(error)")
                return
            }
            
            guard let document = snapshot?.documents.first else {
                print("No documents found")
                return
            }
            
            if let userInfo = try? document.data(as: PersonalDetails.self) {
                self.userName = userInfo.name
            }
        }
    }
    
    private func fetchStocksBalance() {
        db.collection("Accounts").document(userId).collection("Stocks").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting Stock: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            let prices = documents.compactMap { doc -> Double? in
                return try? doc.data(as: StockTransaction.self).price
            }
            
            self.stocksBalance = prices.reduce(0, +)
            updateAccountBalance()
        }
    }
    
    private func fetchCreditBalance() {
        db.collection("Accounts").document(userId).collection("Credit").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting Credit: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            let balances = documents.compactMap { doc -> Double? in
                return try? doc.data(as: Transaction.self).price
            }
            
            self.creditBalance = balances.reduce(0, +)
            updateAccountBalance()
        }
    }
    
    private func fetchSavingsBalance() {
        db.collection("Accounts").document(userId).collection("Savings").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting Savings: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            let amounts = documents.compactMap { doc -> Double? in
                return try? doc.data(as: SavingsEntry.self).amount
            }
            
            self.savingsBalance = amounts.reduce(0, +)
            updateAccountBalance()
        }
    }
    
    private func updateAccountBalance() {
        self.accountBalance = self.savingsBalance + self.creditBalance + self.stocksBalance
    }
}

#Preview {
    HomeView()
}
