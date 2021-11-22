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
    
    // toggle() to update UI
    @Published var updateUI: Bool = false
    
    var user = UserService.shared.user
    
    init(){
        
    }
    
    // MARK -- Authentication Methods
    
    func checkLogin(){
        // Check if there is a user to determine login status
        loggedIn = Auth.auth().currentUser != nil ? true : false
        
        // check if user meta data has been fetched
        // if user already logged in, get data from seperate call
        if user.userName == nil {
            getUserData()
        }
    }
    
    // MARK -- Data Methods
    
    func getUserData() {
        
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // get meta data for that user
        let db = Firestore.firestore()
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        ref.getDocument { snapshot, error in
            
            // check theres no error
            guard error == nil, snapshot != nil else {
                return
            }
            
            // parse data out and set the user meta data
            let data = snapshot?.data()
            self.user.name = data?["name"] as? String
            self.user.userName = data?["userName"] as? String
            // TODO -- need to make a function that maps the firebase usersDogs array to users array
            //      -- will have to convert document reference paths to Dog objects and add them to array
            
            self.updateUI.toggle()
            
        }
    }
    
    // MARK -- Dog Data Methods
    
    func addDog(dogsName: String) {
        
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // create firebase dog document
        let db = Firestore.firestore()
        let dogsColRef = db.collection("dogs")
        let dogDocRef = dogsColRef.document()
        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        let dog = Dog()
        
        // Assigning the fields of the dog
        dogDocRef.setData(["name" : dogsName, "owner" : userRef])
        
        userRef.getDocument { snapshot, error in
            
            // check theres no error
            guard error == nil, snapshot != nil else {
                return
            }
            
            // add dog to users array
            userRef.updateData(
                ["usersDogs" : FieldValue.arrayUnion([dogDocRef])]
            )
            
        }
        dog.name = dogsName
        self.user.usersDogs = []
        self.user.usersDogs?.append(dog)
        print(self.user.usersDogs?[0].name ?? "no dogs")
        self.updateUI.toggle()
    }
    
    
    
}
