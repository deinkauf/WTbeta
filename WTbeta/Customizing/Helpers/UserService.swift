//
//  UserService.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import Foundation

// makes sure all references are pointing to the correct current user's User() model
class UserService {
    
    var user = User()
    
    static var shared = UserService()
    
    private init() {
        
    }
    
}
