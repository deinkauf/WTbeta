//
//  CreateDogView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/20/21.
//

import SwiftUI

struct CreateDogView: View {
    
    @EnvironmentObject var model: UserVM
    @State var name: String = ""
    @State var breed: String = ""
    @State var bio: String = ""
    @State var errorMessage: String?
    
    var body: some View {
        VStack {
            TextField("dog name", text: $name)
            TextField("dog breed", text: $breed)
            TextField("dog bio", text: $bio)
            
            if errorMessage != nil {
                Text(errorMessage!).foregroundColor(.red)
            }

            Button {
                if name != "" && breed != "" && bio != "" {
                    errorMessage = nil
                    model.createDog(name: name, breed: breed, bio: bio, age: 1)
                } else {
                    errorMessage = "All fields are required! :)"
                }
                
            } label: {
                Text("create dog")
            }

        }.padding()
    }
}

struct CreateDogView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDogView()
    }
}
