//
//  DogParkVM.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/23/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


class DogParkVM: ObservableObject {
    
    @Published var dogIDsCheckedIn = [String]()
    
    @Published var dogsCheckedIn = [Dog]()
    
    @Published var dogPark: DogPark?
    
    var dogParkID = ""
    
    private var db = Firestore.firestore()
    
    init(dogParkID: String){
        self.dogParkID = dogParkID
    }
    
    func fetchData() {
        db.collection("dogParks").document(dogParkID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("no document")
                return
            }
            
            self.dogPark = try? document.data(as: DogPark.self)
            if self.dogPark != nil {
                if !self.dogPark!.dogsCheckedIn.isEmpty {
                    self.dogIDsCheckedIn = self.dogPark!.dogsCheckedIn
                }
            }
        }
    }
    
    
//    func fetchDog(dogID: String) -> Dog {
//        var dog: Dog
//        db.collection("dogs").document(dogID).addSnapshotListener { documentSnapshot, error in
//            guard let document = documentSnapshot else {
//                print("no document")
//                return
//            }
//            
//            dog = try document.data(as: Dog.self)
//        }
//        return dog
//    }

    
    
//    func fetchDogParkData(dogParkID: String) {
//        let db = Firestore.firestore()
//        let docRef = db.collection("dogParks").document(dogParkID)
//        docRef.getDocument { document, error in
//            if let error = error as NSError? {
//                print(error)
//            }
//            else {
//                if let document = document {
//                    do {
//                        self.dogPark = try document.data(as: DogPark.self)
//                        print("dog checked in")
//                        print(self.dogPark?.dogsCheckedIn)
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//        fetchDogsCheckedIn()
//        self.updateUI.toggle()
//    }
//
//    func fetchDogsCheckedIn() {
//
//        // checked that theres a dogpark model
//        guard self.dogPark != nil else {
//            return
//        }
//
//        for dogID in self.dogPark!.dogsCheckedIn {
//            appendDogIDtoDogsCheckedIn(dogID: dogID)
//        }
//    }
//
//    func appendDogIDtoDogsCheckedIn(dogID: String) {
//        let db = Firestore.firestore()
//        let docRef = db.collection("dogs").document(dogID)
//        docRef.getDocument { document, error in
//            if let error = error as NSError? {
//                print(error)
//            }
//            else {
//                if let document = document {
//                    do {
//                        let dog = try document.data(as: Dog.self)
//                        print("dog converted")
//                        print(dog)
//                        if dog != nil { self.dogsCheckedIn.append(dog!) }
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//    }
}
