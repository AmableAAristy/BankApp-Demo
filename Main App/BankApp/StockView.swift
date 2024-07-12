//
//  StockView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/30/24.
//

import SwiftUI

struct StockView: View {
    
    @State private var stockName: String = ""
    @State private var suggestions: [String] = []
    @Environment(\.presentationMode) var presentationMode
    
    private let trie = Trie()
    
    init() {
        let words = loadWords(from: "ticker")
        for word in words {
            trie.insert(word)
        }
    }
    
    var body: some View {
        
        NavigationStack{
            VStack {
                Image ("Stock")
                Spacer()
                HStack{
                    
                    VStack{
                        
                        if !suggestions.isEmpty {
                            List(suggestions, id: \.self) { suggestion in
                                Text(suggestion)
                                    .onTapGesture {
                                        stockName = suggestion
                                        suggestions.removeAll()
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                            .frame(height: 200)
                            
                        }
                        
                        TextField("Search for symbols!", text: Binding(
                            get: {
                                self.stockName
                            },
                            set: { newValue in
                                self.stockName = newValue.uppercased().filter { $0.isUppercase }
                                self.updateSuggestions()
                            }
                        ))
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: stockName) { newValue in
                            updateSuggestions()
                        }
                        .padding(.horizontal)
                        
                        
                    }//end vstack
                    NavigationLink(destination: SingleStockView(stockName: stockName)){
                        Text("Search")
                    }
                    
                    
                }//end Hstack
                Spacer()
                .padding()
            }//endVstack
        }
    }
    private func updateSuggestions() {
        if stockName.isEmpty {
            suggestions.removeAll()
        } else {
            suggestions = trie.search(stockName)
        }
    }
}

#Preview {
    StockView()
}
