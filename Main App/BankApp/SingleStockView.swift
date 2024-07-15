import SwiftUI
import Charts
import Firebase
import FirebaseFirestoreSwift

struct SingleStockView: View {
    @StateObject private var serverConnection = ServerConnection()
    @State private var openInfo = false
    let stockName: String
    @State private var length: String = "1mo"
    let lengthOfSearch: [String] = ["5d", "1mo", "3mo", "1y", "5y", "ytd"]
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? "SKXM8NNBc2SNUGJ7a8it8cVJpL72"
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        let colorOfGraph = (serverConnection.bothPrices.first?.0 ?? 0) <= (serverConnection.bothPrices.last?.1 ?? 0) ? Color.green : Color.red
        
        VStack {
            Text("\(stockName)")
            if serverConnection.dates.count > 0 {
                Text("Dates: \(serverConnection.dates.first ?? "\(length)") - \(serverConnection.dates.last ?? "")")
            }
            
            Chart {
                ForEach(Array(serverConnection.bothPrices.enumerated()), id: \.offset) { index, price in
                    LineMark(
                        x: .value("Index", index),
                        y: .value("Open", price.0)
                    )
                    .interpolationMethod(.catmullRom)
                    
                    LineMark(
                        x: .value("Index", index),
                        y: .value("Close", price.1)
                    )
                    .interpolationMethod(.catmullRom)
                }
            }
            .foregroundStyle(colorOfGraph)
            .chartYScale(domain: yAxisRange())
            .frame(height: 200)
            .padding()
            
            HStack {
                ForEach(lengthOfSearch, id: \.self) { date in
                    Button(action: { length = date }) {
                        Text(date)
                    }
                }
            }
            
            List {
                Section(header: Text("Open and Close Prices for \(stockName)")) {
                    DisclosureGroup("Info", isExpanded: $openInfo) {
                        HStack {
                            Text("Date")
                            Spacer()
                            Text("Open")
                            Spacer()
                            Text("Close")
                            Spacer()
                        }
                        ForEach(Array(serverConnection.bothPrices.enumerated()), id: \.offset) { index, price in
                            HStack {
                                Text("\(serverConnection.dates[index])")
                                Spacer()
                                Text("\(price.0, specifier: "%.2f")")
                                Spacer()
                                Text("\(price.1, specifier: "%.2f")")
                                Spacer()
                            }
                            .swipeActions {
                                Button(action: {
                                    addStock(company: stockName, purchaseDate: serverConnection.dates[index], price: price.1)
                                }) {
                                    Text("Buy")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
            .onAppear {
                serverConnection.fetchBothPrices(ticker: stockName, length: length)
            }
            .onChange(of: length) { newLength in
                serverConnection.fetchBothPrices(ticker: stockName, length: newLength)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Stock Transaction"), message: Text(alertMessage))
        }
        .overlay(
            Group {
                if serverConnection.isLoading {
                    VStack {
                        Text("Now Loading.....")
                        ProgressView()
                    }
                }
            }
        )
    }
    
    func yAxisRange() -> ClosedRange<Double> {
        let allPrices = serverConnection.bothPrices.flatMap { [$0.0, $0.1] }
        guard let minPrice = allPrices.min(), let maxPrice = allPrices.max() else {
            return 0...1
        }
        let range = maxPrice - minPrice
        let offset = range * 0.10 // Adds a 10% offset
        return (minPrice - offset)...(maxPrice + offset)
    }
    
    func addStock(company: String, purchaseDate: String, price: Double) {
        let stockBuy = StockTransaction(company: company, purchaseDate: purchaseDate, price: price, timestamp: Timestamp(date: Date()))
        
        do {
            let _ = try db.collection("Accounts").document(userId).collection("Stocks").addDocument(from: stockBuy) { error in
                if let error = error {
                    print("Error writing Stock to Firestore: \(error)")
                    alertMessage = "Error writing Stock to Firestore: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    print("Stock successfully added to Firestore")
                    alertMessage = "Stock successfully added to Firestore"
                    showAlert = true
                }
            }
        } catch {
            print("Error adding document: \(error)")
            alertMessage = "Error adding document: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

#Preview {
    SingleStockView(stockName: "AMD")
}
