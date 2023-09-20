//
//  SplashScreenCoordinator.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 15.9.23..
//

import SwiftUI
import UIKit
import Combine

class SplashScreenCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    func start() {
        let view = SplashScreenView()
        rootViewController = UIHostingController(rootView: view)
    }
}
