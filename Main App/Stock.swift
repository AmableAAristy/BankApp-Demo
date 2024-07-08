//
//  Stock.swift
//  BankApp
//
//  Created by Amable A Aristy  on 6/30/24.
//

import Foundation
struct Stock: Decodable {
    let symbol: String
    let price: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case price = "05. price"
        case date = "07. latest trading day"
    }
}
