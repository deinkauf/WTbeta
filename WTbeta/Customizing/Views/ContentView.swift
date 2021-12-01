//
//  CustomContentView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/14/21.
//



import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var body: some View {
        
        TabView {
            HomeView()
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
        ContentView()
            .environmentObject(UserVM())
    }
}
