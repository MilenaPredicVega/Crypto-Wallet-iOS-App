//
//  TextExtensions.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 15.9.23..
//

import SwiftUI

enum TextStyle {
    case splashScreenWelcome
    case wolly
    case title
    case customFont(String, size: CGFloat, opacity: Double, color: Color)
    
    func styleAttributes() -> (font: Font, opacity: Double, color: Color) {
        switch self {
        case .splashScreenWelcome:
            return (.custom("Titlium Web", size: 28), 0.5, .white)
        case .wolly:
            return (.custom("Titlium Web", size: 48), 1, .white)
        case .title:
            return (.custom("Titlium Web", size: 26), 1, .white)
        case .customFont(let fontName, let size, let opacity, let color):
            return (.custom(fontName, size: size), opacity, color)
        }
    }
}

extension Text {
    func applyTextStyle(_ style: TextStyle) -> some View {
        let (font, opacity, color) = style.styleAttributes()
        
        return self
            .font(font)
            .opacity(opacity)
            .foregroundColor(color)
    }
}


