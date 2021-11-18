//
//  GlowRectangle.swift
//  WTbeta
//
//  Created by Mason Hendry on 8/11/21.
//
import SwiftUI

struct GlowRectangle: View {
    
    @State var text: String = ""
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack {
                AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), center: .center, angle: .degrees(0))
                    .blendMode(.overlay)
                    .blur(radius: 8.0)
                    .mask(
                        RoundedRectangle(cornerRadius: 16.0)
                            .frame(height: 50)
                            .frame(maxWidth: geometry.size.width - 16)
                            .blur(radius: 8.0)
                    )
                
                Text(text)
                    .foregroundColor(Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)))
                    .font(.headline)
                    .frame(width: geometry.size.width - 16, height: 50)
                    .background(
                        Color(.white)
                            .opacity(0.9)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16.0)
                            .stroke(Color.white, lineWidth: 1.0)
                            .blendMode(.normal)
                            .opacity(0.7)
                    )
                    .cornerRadius(16.0)
            }
        }
        .frame(height: 50.0)
    }
}

struct GlowRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1))]),
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea(edges: .all)
            GlowRectangle()
        }
    }
}
