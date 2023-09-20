//
//  ApplicationCoordinator.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 15.9.23..
//

import UIKit
import SwiftUI
import Combine

protocol Coordinator {
    func start() -> ()
}

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let authRepository: AuthenticationRepositoryImpl
    
    var childCoordinators = [Coordinator]()
    
    let authViewModel: AuthenticationViewModel
    
    var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
        self.authRepository = AuthenticationRepositoryImpl(networkService: NetworkingService())
        self.authViewModel = AuthenticationViewModel(repository: authRepository)
    }
    
    func start() {
        self.authRepository.tokenExists
            .sink { [weak self] tokenExists in
                if !tokenExists {
                    let splashScreenCoordinator = SplashScreenCoordinator()
                    splashScreenCoordinator.start()
                    self?.childCoordinators = [splashScreenCoordinator]
                    self?.window.rootViewController = splashScreenCoordinator.rootViewController
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let authScreenCoordinator = AuthenticationScreenCoordinator(viewModel: self!.authViewModel)
                        authScreenCoordinator.start()
                        self?.childCoordinators = [authScreenCoordinator]
                        self?.window.rootViewController = authScreenCoordinator.rootViewController
                    }
                } else {
                    let dashboardCoordinator = DashboardScreenCoordinator()
                    dashboardCoordinator.start()
                    self?.childCoordinators = [dashboardCoordinator]
                    self?.window.rootViewController = dashboardCoordinator.rootViewController
                }
            }
            .store(in: &subscriptions)
    }
}
