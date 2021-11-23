//
//  CreateDogView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/20/21.
//

import SwiftUI

struct CreateDogView: View {
    
    @EnvironmentObject var model: UserModel
    @State var dogsName: String = ""
    
    var body: some View {
        VStack {
            TextField("dog name", text: $dogsName)
            Button {
                model.createDog(name: dogsName)
            } label: {
                Text("add dog")
            }

        }
    }
}

struct CreateDogView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDogView()
    }
}
