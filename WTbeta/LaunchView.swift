//
//  LaunchView.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/16/21.
//

import SwiftUI
import FirebaseEmailAuthUI

struct LaunchView: View {
    
    // in actual app, loggedIn variable should be within the viewModel
    @State var loggedIn: Bool = false
    @State var loginFormShowing: Bool = false
    
    var body: some View {
        
        // check the logged in property and show the appropriate view
        if !loggedIn {
            
            Button {
                
                // show the login form
                loginFormShowing = true
                
            } label: {
                Text("Sign In")
            }
            .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                LoginForm()
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
        loggedIn = FUIAuth.defaultAuthUI()?.auth?.currentUser == nil ? false : true
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
