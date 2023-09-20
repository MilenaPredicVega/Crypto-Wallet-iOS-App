//
//  DashboardScreenCoordinator.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import UIKit
import SwiftUI

class DashboardScreenCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    func start() {
        let dashboardView = DashboardScreenView()
        self.rootViewController = UIHostingController(rootView: dashboardView)
    }
    
}
