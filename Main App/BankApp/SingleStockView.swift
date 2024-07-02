//
//  SingleStockView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/1/24.
//

import SwiftUI
import Charts

struct SingleStockView: View {
    @StateObject private var serverConnection = ServerConnection()
    @State private var openInfo = false
    let stockName: String
    @State private var length:String = "1mo"
    let dates: [String] = ["5d", "1mo", "3mo", "1y", "5y", "ytd"]
    
    var body: some View {
        VStack {
            Text("\(stockName)")
            
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
            .foregroundStyle(serverConnection.bothPrices.first?.0 ?? 0 <= serverConnection.bothPrices.last?.1 ?? 0 ? Color.green : Color.red)
            .chartYScale(domain: yAxisRange())
            .frame(height: 200)
            .padding()
            
            
            HStack{
                ForEach(dates, id: \.self) {
                    date in
                    Button(action:{ length = date}){
                        Text(date)
                    }
                    
                }
            }
            
            

            List {
                Section(header: Text("Open and Close Prices for \(stockName)")) {
                    DisclosureGroup("Info", isExpanded: $openInfo) {
                        ForEach(serverConnection.bothPrices, id: \.open) { price in
                            HStack {
                                Text("Open: \(price.open, specifier: "%.2f")")
                                Spacer()
                                Text("Close: \(price.close, specifier: "%.2f")")
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
    }
    //closedrange makes it so that it returns two different numbers basically since I am returning the bounds + 10% it is perfect
    private func yAxisRange() -> ClosedRange<Double> {
        let allPrices = serverConnection.bothPrices.flatMap { [$0.open, $0.close] }
        guard let minPrice = allPrices.min(), let maxPrice = allPrices.max() else {
            return 0...1
        }
        let range = maxPrice - minPrice
        let offset = range * 0.10 // Adds a 10% offset
        return (minPrice - offset)...(maxPrice + offset)
    }
}

#Preview {
    SingleStockView(stockName: "FORD")
}

