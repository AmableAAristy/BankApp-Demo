//
//  ContentView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/25/24.
//

import SwiftUI



struct ContentView: View {
    
    @State private var totalBalance: Double = 25000.0 // Example total balance

       var savingsAmount: Double {
           return totalBalance * 0.4 // 40% to savings
       }

       var creditAmount: Double {
           return totalBalance * 0.5 // 50% to credit
       }

       var investmentAmount: Double {
           return totalBalance * 0.2 // 20% to investment
       }

       var body: some View {

           TabView{
               HomeView()
                   .tabItem {
                       Image(systemName: "house.fill")
                       Text("Home")
                   }

               StockView()
                   .tabItem {
                       Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                       Text("Stocks")
                   }

               ProfileView()
                   .tabItem {
                       Image(systemName: "person.fill")
                       Text("Profile")
                   }
           }
       }
   }


#Preview {
    ContentView()
}
