//
//  SplashScreenView.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 15.9.23..
//

import SwiftUI

struct SplashScreenView: View {

    var body: some View {
            VStack {
                Image("logo")
                    .padding(.bottom, 20)
                Text(SplashScreensStrings.welcomeText)
                    .applyTextStyle(.splashScreenWelcome)
                Text(SplashScreensStrings.wollyText)
                    .applyTextStyle(.wolly)
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .linearGradientBackground(from: Color.primaryBlue, to: Color.primaryGreen)
            .edgesIgnoringSafeArea(.all)
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
