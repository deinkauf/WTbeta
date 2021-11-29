//
//  SettingsView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var model: UserVM
        
        var body: some View {
            Button {
                try! Auth.auth().signOut()
                self.model.loggedIn = false
            } label: {
                Text("sign out")
            }
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
