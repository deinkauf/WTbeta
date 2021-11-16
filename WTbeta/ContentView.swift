//
//  ContentView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/14/21.
//

import SwiftUI
import FirebaseEmailAuthUI

struct ContentView: View {
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        
        VStack(spacing: 10) {
            Text("Succesfully logged in to Waggin' Tails App")
            Button {
                try! FUIAuth.defaultAuthUI()?.signOut()
                loggedIn = false
            } label: {
                Text("sign out")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loggedIn: .constant(true))
    }
}
