//
//  View+Extension.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 15.9.23..
//

import SwiftUI

extension View {
    func linearGradientBackground(
        from startColor: Color,
        to endColor: Color,
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: startColor, location: 0),
                    .init(color: endColor, location: 1)
                ]),
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
    }
}

