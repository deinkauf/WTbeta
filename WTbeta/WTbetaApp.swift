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
        let db = Firestore.firestore()
        
        let usersColRef = db.collection("users")
        
        let userDocRef = usersColRef.document("xcodeUser")
        
        userDocRef.setData(["name" : "xcodeUserName", "usersDogs" : []])
        
        let userDocRefPath = db.document(userDocRef.path)
        
        let dogsColRef = db.collection("dogs")
        
        let dogDocRef = dogsColRef.document("xcodeDog")
        
        dogDocRef.setData(["name" : "xcodeDogName", "owner" : userDocRefPath])
        
        let dogDocRefPath = db.document(dogDocRef.path)
        
        userDocRef.updateData(
            ["usersDogs" : FieldValue.arrayUnion([dogDocRefPath])]
        )
        
        let dogParksColRef = db.collection("dogParks")
        
        let dogParkDocRef = dogParksColRef.document("xcodeDogPark")
        
        dogParkDocRef.setData(["name" : "xcodeDogParkName", "dogsCheckedIn" : []])
        
        let dogParkDocRefPath = db.document(dogParkDocRef.path)
        
        userDocRef.updateData(["defaultDogPark" : dogParkDocRefPath])
        
        checkInDog(dog: dogDocRef, dogPark: dogParkDocRef)
    }
    
    func checkInDog (dog: DocumentReference, dogPark: DocumentReference) {
        dogPark.updateData(
            ["dogsCheckedIn" : FieldValue.arrayUnion([dog.path])]
        )
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
    }
}
