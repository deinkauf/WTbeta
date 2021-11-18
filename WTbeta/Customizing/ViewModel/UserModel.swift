//
//  UserModel.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import Foundation
import Firebase
import FirebaseAuth

class UserModel: ObservableObject {
    
    // Authentication
    @Published var loggedIn = false
    
    
    init(){
        
    }
    
    // MARK -- Authentication Methods
    
    func checkLogin(){
        // Check if there is a user to determine login status
        loggedIn = Auth.auth().currentUser != nil ? true : false 
    }
    
}
