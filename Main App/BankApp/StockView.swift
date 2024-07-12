import SwiftUI

struct StockView: View {
    @State private var stockName: String = ""
    @State private var suggestions: [String] = []
    
    private let trie = Trie()
    
    init() {
        let words = loadWords(from: "ticker")
        for word in words {
            trie.insert(word)
        }
    }
    
    var body: some View {
        VStack {
            Image("Stock")
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(height: 550)
            VStack {
                TextField("Search for symbols!", text: Binding(get: {
                    self.stockName},
                    set: {newValue in
                    self.stockName = newValue.uppercased().filter {$0.isUppercase}
                    self.updateSuggestions()
                }
                                                              ))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: stockName) { newValue in
                    self.updateSuggestions()
                }
                .padding(.horizontal)
                if suggestions.isEmpty {
                    EmptyView()
                } else {
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
            NavigationLink(destination: SingleStockView(stockName: stockName)) {
                Text("Search")
            }
        }
        .padding()
    }
    
    private func updateSuggestions() {
        if stockName.isEmpty {
            suggestions.removeAll()
        } else {
            suggestions = trie.search(stockName)
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
