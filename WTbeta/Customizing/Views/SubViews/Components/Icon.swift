//
//  Icon.swift
//  WTbeta
//
//  Created by Mason Hendry on 8/7/21.
//
import SwiftUI

struct Icon: View {
    
    //Change this to targeted Symbol to Preview Display
    @State var IconSymbol: String = ""
    
    var body: some View {
        
        ZStack {
            //WARNING -- DO NOT UNCOMMENT WHILE FULL CODE RUNNING
            //In place to display white glow background
//            Color(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1))
//                .opacity(0.7)
//                .ignoresSafeArea(edges: .all)
            
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), center: .center, startAngle: .init(degrees: -190), endAngle: .degrees(155))
                .blur(radius: 8)
                .shadow(radius: 30)
                .frame(width: 32, height: 32)

            Image(IconSymbol)
                .linearGradientBackground(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1))])
                .frame(width: 36.0, height: 36)
                .background(Color(.white).opacity(0.8))
                .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.white.opacity(0.7), lineWidth: 1).blendMode(.overlay))
        }
    }
}

struct PasswordIcon_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1))]),
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea(edges: .all)
            Icon()
        }
    }
}
