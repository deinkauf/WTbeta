//
//  CreateAccountForm.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/16/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CreateAccountForm: View {
    
    @Binding var createAccountFormShowing: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Email", text: $email)
                    TextField("Name", text: $name)
                    SecureField("Password", text: $password)
                }
                
                // section to display error message
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!).foregroundColor(.red)
                    }
                }
                
                Button {
                    //perform create account
                    createAccount()
                } label: {
                    
                    HStack {
                        Spacer()
                        Text("Create Account")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Create Account")
        }
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    createUserDoc()
                    createAccountFormShowing = false
                } else {
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
    
    func createUserDoc() {
        if let currentUser = Auth.auth().currentUser {
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
            let userDoc = db.collection("users").document(currentUser.uid)
            userDoc.setData(["name" : trimmedName, "usersDogs" : []])
        }
    }
}

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountForm(createAccountFormShowing: .constant(true))
    }
}
