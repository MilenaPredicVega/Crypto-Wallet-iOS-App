//
//  NetworkRouter.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//
import Alamofire
import Foundation

protocol NetworkRoutable {
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var url: String { get }
    var encoder: NetworkParameterEncoder { get }
}
