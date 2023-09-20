//
//  CreateAccountAPIRequest.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import Foundation

struct CreateAccountAPIRequest: Encodable {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
}

struct LoginAPIRequest: Encodable {
    let email: String
    let password: String
}
