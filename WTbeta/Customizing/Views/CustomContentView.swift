//
//  CustomContentView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/14/21.
//



import SwiftUI
import FirebaseAuth
import Firebase

struct CustomContentView: View {
    
    @EnvironmentObject var model: UserModel
    
    var body: some View {
        
//        NavigationView {
//            VStack(spacing: 10) {
//
//                Text("hello \(self.model.user.userName ?? "") !!")
//                Text("your dogs name is \(self.model.user.usersDogs.last?.name ?? "no dogs")")
//                Text("Succesfully logged in to Waggin' Tails App")
//                Button {
//                    try! Auth.auth().signOut()
//                    self.model.loggedIn = false
//                } label: {
//                    Text("sign out")
//                }
//
//                NavigationLink(destination: CreateDogView()) {
//                    Text("Create Dog")
//                }
//            }
//        }
        
        TabView {
            DefaultDogParkView()
                .tabItem {
                    Image(systemName: "house")
                }
            MapView()
                .tabItem {
                    Image(systemName: "globe")
                }
            UserProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(Color(#colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.4823529412, alpha: 1)))
        
    }
}

struct CustomContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomContentView()
            .environmentObject(UserModel())
    }
}
