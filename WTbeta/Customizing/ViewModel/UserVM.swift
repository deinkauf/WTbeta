//
//  UserModel.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/17/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class UserVM: ObservableObject {
    
    @Published var dogs = [Dog]()
    
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
            
            //set document to a user model
            
            // parse data out and set the user meta data
            let data = snapshot?.data()
            self.user.name = data?["name"] as? String ?? ""
            self.user.userName = data?["userName"] as? String ?? ""
            self.updateUI.toggle()
            // function to map dog docs to dog models
            if let userDocDogs = data?["usersDogs"] as? [DocumentReference] {
                for dog in userDocDogs {

                    // for each dog doc, create and append a dog() model
                    dog.getDocument { snapshot1, error in

                        // check theres no error
                        guard error == nil, snapshot1 != nil else {
                            return
                        }
                        
                        // parse data out and set the dog meta data
                        let tempDog = Dog()
                        let data1 = snapshot1?.data()
                        tempDog.name = data1?["name"] as? String ?? ""
                        tempDog.ownerID = data1?["owner"] as? String ?? ""
                        
                        if tempDog.id != "" && tempDog.id != nil {
                            self.user.usersDogs.append(tempDog.id!)
                            self.dogs.append(tempDog)
                        }
                        print("--------------------------------")
                        print(self.user.usersDogs)
                        print(tempDog.name)
                        self.updateUI.toggle()
                    }
                }
            }
        }
    }
    
    // MARK -- Dog Data Methods
    
//    func createDog(name: String) {
//        
//        // create local Dog model
//        var dog = Dog()
//        dog.name = name
//        dog.ownerID = self.user
//        
//        // add it to local User
//        dogs.append(dog)
//        
//        // create DB Dog doc
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
//        let dogDoc = db.collection("dogs").addDocument(data: ["name": name, "owner": userRef])
//        
//        // add it to DB User doc
//        userRef.getDocument { snapshot, error in
//
//            // check theres no error
//            guard error == nil, snapshot != nil else {
//                return
//            }
//
//            // add dog to users array
//            userRef.updateData(
//                ["usersDogs" : FieldValue.arrayUnion([dogDoc])]
//            )
//        }
//        print(self.user.usersDogs.last?.name ?? "no dogs")
//        self.updateUI.toggle()
//    }
}
