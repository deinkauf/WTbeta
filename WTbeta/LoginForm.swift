//
//  LoginForm.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/16/21.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    @Binding var loginFormShowing: Bool
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                // section to display error message
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!).foregroundColor(.red)
                    }
                }
                
                Button {
                    //perform login
                    signIn()
                } label: {
                    
                    HStack {
                        Spacer()
                        Text("Sign in")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Sign In")
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            // triggers changes in view code so put on main thread
            DispatchQueue.main.async {
                if error == nil {
                    // dismiss this sheet
                    loginFormShowing = false
                } else {
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(loginFormShowing: .constant(true))
    }
}
