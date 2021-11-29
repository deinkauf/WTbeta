//
//  CustomNumField.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//

import SwiftUI

struct CustomNumField: View {
    @State var symbolName: String = ""
    @State var textFieldtext: String = ""
    //TODO -- CHANGE AGE TO AN INT AND ENSURE IT PASSES PROPERLY
    @Binding private(set) var userFieldEntry: String
    
    var showingSecureField = false
    
    var body: some View {
        
        HStack(spacing: 12.0){
            Icon(IconSymbol: symbolName)
                .padding(.horizontal, 5)
            TextField(textFieldtext, text: $userFieldEntry)
                .colorScheme(.dark)
                .foregroundColor(.white)
                .autocapitalization(.none)
                .keyboardType(.decimalPad)
            
        }
        .frame(height: 52)
        .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 1.0)
                    .blendMode(.overlay)
        )
    }
}

//struct CustomNumField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomNumField()
//    }
//}
