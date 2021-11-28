//
//  LaunchView.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import SwiftUI
import FirebaseAuth

struct CustomLaunchView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var body: some View {
        
        
        if userVM.loggedIn == false {
            
            IntroTabView()
                .onAppear {
                    self.userVM.checkLogin()
                }
            
        }
        else {
            
            CustomContentView()
            
        }
        
    }
}

struct CustomLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLaunchView()
    }
}
