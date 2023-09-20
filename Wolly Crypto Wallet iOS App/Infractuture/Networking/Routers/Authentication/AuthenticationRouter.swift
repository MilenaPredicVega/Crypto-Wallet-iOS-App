//
//  AuthenticationRouter.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import Foundation
import Alamofire

enum AuthenticationRouter: NetworkRoutable {
    
    case logIn
    case registration
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .logIn, .registration:
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .logIn, .registration:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .logIn:
            return "users/login"
        case .registration:
            return "users/register"
        }
    }
    
    var url: String {
        switch self {
        case .logIn, .registration:
            return APIConstants.baseURL + path
        }
    }
    
    var encoder: NetworkParameterEncoder {
        switch self {
        case .logIn, .registration:
            return .json
        }
    }
}
