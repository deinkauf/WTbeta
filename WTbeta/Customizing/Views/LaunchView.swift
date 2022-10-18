//
//  LaunchView.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    @EnvironmentObject var userVM: UserVM
    
    var body: some View {
        
        
        if userVM.loggedIn == false {
            
            IntroTabView()
                .onAppear {
                    self.userVM.checkLogin()
                }
            
        } else if userVM.dogs.isEmpty {
            
            AddDogDetails()
        }
        else {
            
            ContentView()
            
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
