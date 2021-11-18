//
//  Extensions.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import SwiftUI

//Extensions are defined here to clean up code when designing views
extension View {
    
    //Background Aesthetics
    func angularGradientGlow(colors: [Color]) -> some View {
        self.overlay(AngularGradient(gradient: Gradient(colors: colors), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, angle: .degrees(0))).mask(self)
                        
    }
    
    func linearGradientBackground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)).mask(self)
    }
    
    public func gradientForeground(colors: [Color]) -> some View {
            self
                .overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
                .mask(self)
        }
    
    func blurBackground() -> some View {
        self
            .padding(16)
            .background(Color(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.2431372549, alpha: 1)).opacity(0.6))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    //The Function is a component of the Onboarding Sequence, enabling frames / cards to be generated with this extension
    func onBoardingFrame() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.7))
                    .background(Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.8), radius: 60, x: 0.0, y: 30)
                    .blur(radius: 20)
            )
            .cornerRadius(30.0)
            .padding(.horizontal)
    }
}
