//
//  CreateAccountForm.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/16/21.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountForm: View {
    
    @Binding var createAccountFormShowing: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Email", text: $email)
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                }
                
                // section to display error message
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
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
                    createAccountFormShowing = false
                } else {
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
}

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountForm(createAccountFormShowing: .constant(true))
    }
}
