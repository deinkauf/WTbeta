//
//  LaunchView.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import SwiftUI
import FirebaseAuth

struct CustomLaunchView: View {
    
    @EnvironmentObject var model: UserModel
    
    var body: some View {
        
        VStack{
            
        }
        if model.loggedIn == false {
            
            IntroTabView()
                .onAppear {
                    model.checkLogin()
                }
            
        }
        else {
            
            CustomContentView()
            
        }
        
    }
    
    private func checkLogin() {
        model.loggedIn = Auth.auth().currentUser == nil ? false : true
    }
}

struct CustomLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLaunchView()
    }
}
