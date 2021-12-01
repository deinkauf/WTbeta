//
//  UserProfileView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userVM: UserVM
        
        var body: some View {
            
            NavigationView {
                VStack(spacing: 10) {
                    
                    HStack {
                        Text("Your Dogs:")
                            .foregroundColor(Color(#colorLiteral(red: 0.9176450372, green: 0.3724507987, blue: 1, alpha: 1)))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        NavigationLink(destination: CreateDogView()) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color(#colorLiteral(red: 0.5216394663, green: 0.2060443163, blue: 1, alpha: 1)))
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    if !self.userVM.dogs.isEmpty {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(self.userVM.dogs) { dog in
                                    DogCard(dog: dog, privateCard: true)
                                }
                            }.padding()
                        }
                        
                    } else {
                        Text("Tap the (+) icon to add your dog!")
                    }
                }
                .navigationTitle(userVM.user.name ?? "no name")
                .toolbar {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
            }
            
        }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
