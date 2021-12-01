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
    
    @Published var hasDefaultDogPark = false
    
    // toggle() to update UI
    @Published var updateUI: Bool = false
    
    var user = UserService.shared.user
    
    private var db = Firestore.firestore()
    
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
    
    func checkDefaultDogPark() {
        hasDefaultDogPark = user.defaultDogParkID != nil ? true : false
    }
    
    func signOut () {
        dogs.removeAll()
        loggedIn = false
        hasDefaultDogPark = false
        try! Auth.auth().signOut()
    }
    
    // MARK -- Data Methods
    
    func getUserData() {
        
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // get meta data for that user
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        ref.getDocument { snapshot, error in
            
            // check theres no error
            guard error == nil, snapshot != nil else {
                return
            }
            
            //set document to a user model
            
            // parse data out and set the user meta data
            let data = snapshot?.data()
            self.user.name = data?["name"] as? String
            self.user.userName = data?["userName"] as? String
            self.user.defaultDogParkID = data?["defaultDogParkID"] as? String
            if self.user.defaultDogParkID != nil {self.hasDefaultDogPark = true}
        }
        print("running getUserDogs()")
        getUserDogs()
    }
    
    func getUserDogs() {
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        db.collection("users").document(Auth.auth().currentUser!.uid).collection("userDogs").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.dogs = documents.compactMap { (queryDocumentSnapshot) -> Dog? in
                return try? queryDocumentSnapshot.data(as: Dog.self)
            }
        }
        print("finished running getUserDogs()")
        print("---- user.dogs ----")
        print(dogs)
    }
    
    // MARK -- Dog Data Methods
    
    func createDog(name: String, breed: String, bio: String, age: Int) {
//        
        // create local Dog model
        let dog = Dog()
        dog.name = name
        dog.breed = breed
        dog.bio = bio
        dog.age = age
        dog.ownerID = Auth.auth().currentUser!.uid
        
        // add it to local UserVM
        self.dogs.append(dog)
        
        // create DB Dog doc
        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        let collectionRef = userRef.collection("userDogs")
          do {
            let newDogDocRef = try collectionRef.addDocument(from: dog)
            print("dog is stored with new ref: \(newDogDocRef)")
          }
          catch {
            print(error)
          }
    }
    
    
}
