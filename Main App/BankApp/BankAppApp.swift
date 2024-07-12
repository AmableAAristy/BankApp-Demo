//
//  BankAppApp.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/25/24.
//

import SwiftUI

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

@main
struct BankAppApp: App {
    

    //this inits
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {

        
        WindowGroup {
            LoginView()
        }
    }
}
