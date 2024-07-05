//
//  FireBase.swift
//  BankApp
//
//  Created by Amable A Aristy  on 7/5/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

struct Transaction: Codable, Identifiable{
    @DocumentID var id: String?
    
    var company: String
    var price: Double
}

