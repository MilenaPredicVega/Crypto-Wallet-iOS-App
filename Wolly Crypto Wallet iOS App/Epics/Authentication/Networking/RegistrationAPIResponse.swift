//
//  RegistrationAPIResponse.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import Foundation

struct RegistrationAPIResponse: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let password: String
    let email: String
    let currentCardBalance: Int
    let role: String
    let wallet: Wallet

    struct Wallet: Decodable {
        let id: String
        let walletItems: [String]
        let user: String
        let totalBalance: Int
    }
}
