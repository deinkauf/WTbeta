//
//  AddDogDetails.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//
import SwiftUI

struct AddDogDetails: View {
    
    @EnvironmentObject var userVM: UserVM
    
    @State var name: String = ""
    @State var breed: String = ""
    @State var age: String = ""
    
    var backgroundColor: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.5803921569, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1))]),
        startPoint: .leading,
        endPoint: .trailing)
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //replace color with background image
                //                backgroundColor
                //                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    VStack {
                        VStack(alignment: .leading, spacing: 16) {
                            //TODO -- ADD PROGRESS TRACKER AT BOTTOM
                            //TITLE
                            Text("Dog Profile")
                                .font(Font.largeTitle.bold())
                                .foregroundColor(.white)
                            
                            //SUBTITLE
                            Text("Introduce your best friend")
                                .font(.subheadline)
                                .foregroundColor(Color.white.opacity(0.7))

                            //DOG NAME TEXT FIELD + ICON
                            CustomTextField(symbolName: "pawprint.fill", textFieldtext: "Your Dog's Name", userFieldEntry: $name)
                            //BREED TEXT FIELD + ICON
                            CustomTextField(symbolName: "rosette", textFieldtext: "Breed Type", userFieldEntry: $breed)
                            //AGE TEXT FIELD + ICON
                            CustomNumField(symbolName: "123.rectangle.fill", textFieldtext: "Age", userFieldEntry: $age)
                            
                            //NEXT BUTTON
                            if name != "" && age != "" && age != "" {
                                NavigationLink(
                                    destination: AddBio(name: name, breed: breed, age: age),
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
            }
            .navigationBarHidden(true)
        }
    }
}

struct AddDogDetails_Previews: PreviewProvider {
    static var previews: some View {
        AddDogDetails()
    }
}
