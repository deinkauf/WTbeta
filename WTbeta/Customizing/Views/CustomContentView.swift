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
    @State var userName: String = ""
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Text("Hello \(userName)!!")
            Text("Succesfully logged in to Waggin' Tails App")
            Button {
                try! Auth.auth().signOut()
                model.loggedIn = false
            } label: {
                Text("sign out")
            }

        }
        .onAppear {
            getCurrentUsersName()
        }
    }
    
    func getCurrentUsersName() {
        if let currentUser = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userDoc = db.collection("users").document(currentUser.uid)
            // Read Data and Handle errors
            userDoc.getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let snapshot = snapshot {
                    userName = snapshot.get("name") as? String ?? ""
                    print("users name should be \(userName)")
                } else {
                    print("no data in getDocument call")
                }
            }
        }
        
    }
}

struct CustomContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomContentView()
            .environmentObject(UserModel())
    }
}
