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
    
    @Published var dogsCheckedIn = [Dog]()
    
    @Published var dogCount = 0
    
    @Published var dogPark: DogPark?
    
    var dogParkID = ""
    
    init(dogParkID: String){
        DispatchQueue.main.async {
            self.dogParkID = dogParkID
            self.fetchData()
        }
        print("-----------------dogparkvm initialized!!")
        print("----------------- dogCount : \(dogsCheckedIn.count)")
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        db.collection("dogParks").document(dogParkID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("no document")
                return
            }
            
            self.dogPark = try? document.data(as: DogPark.self)

        }
        fetchDogs()
    }
    
    
    func fetchDogs() {
        let db = Firestore.firestore()
        db.collection("dogParks").document(dogParkID).collection("dogsCheckedIn").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.dogsCheckedIn = documents.compactMap { (queryDocumentSnapshot) -> Dog? in
                return try? queryDocumentSnapshot.data(as: Dog.self)
            }
        }
    }
    
    func getDogCount() {
        dogCount = dogsCheckedIn.count
    }
    
    func checkInDog(dog: Dog) {
        guard dog.id != nil else {
            return
        }
        dogsCheckedIn.append(dog)
        let db = Firestore.firestore()
        try? db.collection("dogParks").document(dogParkID).collection("dogsCheckedIn").document(dog.id!).setData(from: dog)
    }
    
    func checkOutDog(dog: Dog) {
        guard dog.id != nil else {
            return
        }
        let i = dogsCheckedIn.firstIndex { d in
            d.id == dog.id
        }
        if let i = i {
            dogsCheckedIn.remove(at: i)
        }
        let db = Firestore.firestore()
        try? db.collection("dogParks").document(dogParkID).collection("dogsCheckedIn").document(dog.id!).delete()
    }
}
