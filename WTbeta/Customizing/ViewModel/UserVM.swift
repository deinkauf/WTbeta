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
import FirebaseStorage
import UIKit

class UserVM: ObservableObject {
    
    @Published var dogs = [Dog]()
    
    @Published var dogsCheckingIn = [Dog]()
    
    // Authentication
    @Published var loggedIn = false
    
    @Published var hasDefaultDogPark = false
    
    // toggle() to update UI
    @Published var updateUI: Bool = false
    
    @Published var checkedIn = false
    
    @Published var dogParkCheckedInto = ""
    
    @Published var dogImageLoaded = false
    
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
    
    func checkDefaultDogPark() {
        hasDefaultDogPark = user.defaultDogParkID != nil ? true : false
    }
    
    func signOut() {
        dogs.removeAll()
        dogsCheckingIn.removeAll()
        loggedIn = false
        hasDefaultDogPark = false
        checkedIn = false
        dogParkCheckedInto = ""
        user.defaultDogParkID = nil
        user.name = nil
        user.id = nil
        user.userName = nil
        try! Auth.auth().signOut()
    }
    
    // MARK -- Data Methods
    
    func getUserData() {
        
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        let db = Firestore.firestore()
        
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
        getUserDogs()
    }
    
    func getUserDogs() {
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users").document(Auth.auth().currentUser!.uid).collection("userDogs").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.dogs = documents.compactMap { (queryDocumentSnapshot) -> Dog? in
                return try? queryDocumentSnapshot.data(as: Dog.self)
            }
        }
    }
    
    // MARK -- Dog Data Methods
    
    func createDog(name: String, breed: String, bio: String, age: String, profilePic: UIImage) {
        
        guard Auth.auth().currentUser != nil else {
            return
        }
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
        let db = Firestore.firestore()
        let storageManager = StorageManager()
        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        let collectionRef = userRef.collection("userDogs")
        do {
            let newDogDocRef = try collectionRef.addDocument(from: dog)
            storageManager.upload(image: profilePic, dogID: newDogDocRef.documentID)
            dog.imagePath = "images/\(newDogDocRef.documentID).jpg"
            let storage = Storage.storage()
            let ref = storage.reference().child(dog.imagePath ?? "")
            ref.getData(maxSize: 1 * 1024 * 1024) { imageData, error in
                if let error = error {
                    print("-------------UserVM image url error---------------")
                    print(error)
                    print("-------------UserVM image url error---------------")
                }
                dog.imageData = imageData
            }
            DispatchQueue.main.async {
                newDogDocRef.setData([
                    "imagePath" : dog.imagePath,
                    "imageData" : dog.imageData
                ], merge: true)
                
                
            }
        }
        catch {
            print("-------------create dog error---------------")
            print(error)
            print("-------------create dog error---------------")
        }
    }
    
    func updateDog(dogID: String, name: String, breed: String, bio: String, age: String, profilePic: UIImage, imagePath: String) {
        

        var newImageData: Data?
        
        // create DB Dog doc
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        let collectionRef = userRef.collection("userDogs")
        let dogDocRef = collectionRef.document(dogID)
        //update photo
        let storageManager = StorageManager()
        storageManager.upload(image: profilePic, dogID: dogDocRef.documentID)
        // fetch photo data
        let storage = Storage.storage()
        let ref = storage.reference().child(imagePath)
        ref.getData(maxSize: 1 * 1024 * 1024) { imageData, error in
            if let error = error {
                print("-------------UserVM image url error---------------")
                print(error)
                print("-------------UserVM image url error---------------")
            }
            if let imageData = imageData {
                newImageData = imageData
            }
        }
        
        dogDocRef.updateData([
            "name" : name,
            "breed" : breed,
            "bio" : bio,
            "age" : age,
            "imageData" : newImageData
        ])
        
        print("edited dog is stored with new ref: \(dogDocRef)")
    }
        
    func deleteDog(dogID: String){
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        let collectionRef = userRef.collection("userDogs")
        let dogDocRef = collectionRef.document(dogID)
        let storage = Storage.storage()
        let dogStorRef = storage.reference().child(dogDocRef.documentID)
        
        dogStorRef.delete { error in
            if let error = error {
                print("-------File Deletion Error----------")
                print(error)
                print("-------File Deletion Error----------")
            } else {
                print("File Deleted Successfully")
            }
        }
        
        dogDocRef.delete()
    }
    
    
    // Mark -- DogPark Data Methods
    
    func setDefaultDogPark(dogParkID: String) {
        // checked that theres logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        let db = Firestore.firestore()
        
        user.defaultDogParkID = dogParkID
        db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["defaultDogParkID" : dogParkID])
        checkDefaultDogPark()
    }
    func removeDefaultDogPark() {
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        let db = Firestore.firestore()
        
        user.defaultDogParkID = nil
        db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["defaultDogParkID" : nil])
        checkDefaultDogPark()
    }
    
    func addToDogsCheckingIn(dog: Dog) {
        dogsCheckingIn.append(dog)
    }
    
    func removeFromDogsCheckingIn(dog: Dog) {
        let i = dogsCheckingIn.firstIndex { d in
            d.id == dog.id
        }
        if let i = i {
            dogsCheckingIn.remove(at: i)
        }
    }
    
    func checkIn(dogParkID: String) {
        checkedIn = true
        dogParkCheckedInto = dogParkID
    }
    
    func checkOut() {
        checkedIn = false
        dogParkCheckedInto = ""
    }
    
}
