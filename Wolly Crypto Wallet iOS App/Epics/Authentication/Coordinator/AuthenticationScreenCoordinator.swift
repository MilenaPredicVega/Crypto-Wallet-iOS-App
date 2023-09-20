//
//  AuthenticationScreenCoordinator.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import UIKit
import SwiftUI

class AuthenticationScreenCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    @ObservedObject var viewModel: AuthenticationViewModel
    
    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
    }
    
    func start() {
        let authView = AuthenticationView(viewModel: viewModel)
            self.rootViewController = UIHostingController(rootView: authView)
        
    }
}
