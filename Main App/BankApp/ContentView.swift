//
//  ContentView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/25/24.
//

import SwiftUI



struct ContentView: View {
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Image(systemName: "creditcard")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            
            NavigationLink(destination: SavingsView()) {
                Text("Go to SavingsView")
            }
            NavigationLink(destination: CreditView()) {
                Text("Go to CreditView")
            }
            NavigationLink(destination: StockView()) {
                Text("Go to StockView")
            }
        }
    }
}

#Preview {
    ContentView()
}
