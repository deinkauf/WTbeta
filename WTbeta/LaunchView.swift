//
//  LaunchView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/16/21.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    // in actual app, loggedIn variable should be within the viewModel
    @State var loggedIn: Bool = false
    @State var loginFormShowing: Bool = false
    @State var createAccountFormShowing: Bool = false
    
    var body: some View {
        
        // check the logged in property and show the appropriate view
        if !loggedIn {
            
            VStack {
                Button {
                    
                    // show the login form
                    loginFormShowing = true
                    
                } label: {
                    Text("Sign In")
                        .padding()
                }
                .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                    LoginForm(loginFormShowing: $loginFormShowing)
                }
                
                Button {
                    //show create account form
                    createAccountFormShowing = true
                } label: {
                    Text("Create Account")
                        .padding()
                }
                .sheet(isPresented: $createAccountFormShowing, onDismiss: checkLogin) {
                    CreateAccountForm(createAccountFormShowing: $createAccountFormShowing)
                }

            }
            .onAppear {
                checkLogin()
            }
        } else {
            // show logged in view
            ContentView(loggedIn: $loggedIn)
        }
    }
    
    private func checkLogin() {
        loggedIn = Auth.auth().currentUser == nil ? false : true
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
