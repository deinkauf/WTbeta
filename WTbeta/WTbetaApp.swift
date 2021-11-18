//
//  WTbetaApp.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/14/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct WTbetaApp: App {
    
    init() {
        FirebaseApp.configure()
        addUserToDB()
    }
    
    func addUserToDB() {
        // Reference to the cloud firestore database
        let db = Firestore.firestore()
        
        // Reference to the users collection
        // Will be created if one does not already exist
        let usersColRef = db.collection("users")
        
        // Create a document within the users collection
        let userDocRef = usersColRef.document("xcodeUser")
        
        // Provide a document with the given^ "xcodeuser" identifier
        userDocRef.setData(["name" : "xcodeUserName", "usersDogs" : []])
        
        // retrieving the reference path of the user for future use in the dog object
        let userDocRefPath = db.document(userDocRef.path)
        
        let dogsColRef = db.collection("dogs")
        
        let dogDocRef = dogsColRef.document("xcodeDog")
        
        // Assigning the fields (name and owner) of a specific dog, "xcodeDog" in the "dogs" collection
        dogDocRef.setData(["name" : "xcodeDogName", "owner" : userDocRefPath])
        
        let dogDocRefPath = db.document(dogDocRef.path)
        
        // Updating the user data by "appending" the reference path of the created Dog object to the usre's list of dogs
        userDocRef.updateData(
            ["usersDogs" : FieldValue.arrayUnion([dogDocRefPath])]
        )
        
        let dogParksColRef = db.collection("dogParks")
        
        let dogParkDocRef = dogParksColRef.document("xcodeDogPark")
        
        dogParkDocRef.setData(["name" : "xcodeDogParkName", "dogsCheckedIn" : []])
        
        let dogParkDocRefPath = db.document(dogParkDocRef.path)
        
        userDocRef.updateData(["defaultDogPark" : dogParkDocRefPath])
        
        checkInDog(dog: dogDocRef, dogPark: dogParkDocRef)
        
        // 11/17
        let userDocRef_2 = usersColRef.document("tester2")
        
        userDocRef_2.setData(["name": "Tester2", "userDogs": []])
        
    }
    
    func checkInDog (dog: DocumentReference, dogPark: DocumentReference) {
        dogPark.updateData(
            ["dogsCheckedIn" : FieldValue.arrayUnion([dog.path])]
        )
    }
    
//    var body: some Scene {
//        WindowGroup {
//            LaunchView()
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            CustomLaunchView()
                .environmentObject(UserModel())
        }
    }
}
