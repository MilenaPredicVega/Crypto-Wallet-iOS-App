//
//  DashboardScreenView.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 19.9.23..
//

import SwiftUI

struct DashboardScreenView: View {
    var body: some View {
        //TODO: Implement dashboard screens
        // temporary
        CustomButton(title: "LogOut") {
            clearUserDefaults()
        }
    }
}
func clearUserDefaults() {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    UserDefaults.standard.synchronize()
}

struct DashboardScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreenView()
    }
}
