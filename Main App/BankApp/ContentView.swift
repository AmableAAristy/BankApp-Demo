//
//  ContentView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/25/24.
//

import SwiftUI
import Foundation

struct ContentView: View {

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
