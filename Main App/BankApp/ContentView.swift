//
//  ContentView.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/25/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Image(systemName: "creditcard")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            
            NavigationLink(destination: StockView()) {
                Text("Go to StockView")
            }
        }
    }
}

#Preview {
    ContentView()
}
