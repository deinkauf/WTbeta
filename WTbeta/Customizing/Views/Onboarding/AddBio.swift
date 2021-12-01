//
//  AddBio.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//

import SwiftUI

struct AddBio: View {
    
    @EnvironmentObject var userVM: UserVM
    
    // from AddDogDetails
    var name: String = ""
    var breed: String = ""
    var age: String = ""
    
    @State var bio: String = ""
            
    var backgroundColor: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
        startPoint: .leading,
        endPoint: .trailing)
    
    
    var body: some View {
        ZStack {
            
            backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    //TODO -- ADD PROGRESS TRACKER AT BOTTOM
                    //TITLE
                    Text("Dog Bio")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    //SUBTITLE
                    Text("Introduce your dog and their personality, habits, etc.")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    //TODO -- CHANGE FRAME TO LARGER PARAGRAPH FORMAT FOR MORE TEXT INTAKE
                    //TEXT FIELD + ICON
                    CustomTextField(symbolName: "plus.bubble", textFieldtext: "Make it fun!", userFieldEntry: $bio)
                    
                    //NEXT BUTTON
                    if bio != "" {
                        NavigationLink(
                            destination: AddPic(name: name, breed: breed, age: age, bio: bio),
                            label: {
                                GlowRectangle(text: "Next")
                            })
                    } else {
                        GlowRectangle(text: "Next")
                            .opacity(0.5)
                    }
                }
                .padding(20)
            }
            .onBoardingFrame()
        }
        .navigationBarHidden(true)
    }
}

struct AddBio_Previews: PreviewProvider {
    static var previews: some View {
        AddBio()
    }
}
