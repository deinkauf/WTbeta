//
//  CustomTextField.swift
//  WTbeta
//
//  Created by Mason Hendry on 8/11/21.
//
import SwiftUI

struct CustomTextField: View {
    
    @State var symbolName: String = ""
    @State var textFieldtext: String = ""
    //TODO -- CHANGE AGE TO AN INT AND ENSURE IT PASSES PROPERLY
    @Binding private(set) var userFieldEntry: String
    
    var showingSecureField = false
    
    var body: some View {
        
        HStack(spacing: 12.0){
            Icon(IconSymbol: symbolName)
                .padding(.horizontal, 5)
            if !showingSecureField {
                TextField(textFieldtext, text: $userFieldEntry)
                    .colorScheme(.dark)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
            } else {
                SecureField(textFieldtext, text: $userFieldEntry)
                    .colorScheme(.dark)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
            }
        }
        .frame(height: 52)
        .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 1.0)
                    .blendMode(.overlay)
        )
//        .background(
//            Color(.white)
//                .cornerRadius(16.0)
//                .opacity(0.5)
//        )
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1))]),
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea(edges: .all)
            //CustomTextField()
        }
    }
}
