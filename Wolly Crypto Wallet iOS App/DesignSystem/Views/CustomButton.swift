//
//  CustomButton.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 18.9.23..
//

import SwiftUI

struct CustomButton: View {
    let title: LocalizedStringKey
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .foregroundColor(.white)
                .frame(width: 200, height: 48)
                .linearGradientBackground(from: Color.primaryBlue, to: Color.primaryGreen)
                .cornerRadius(20)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Login", action: {})
    }
}
