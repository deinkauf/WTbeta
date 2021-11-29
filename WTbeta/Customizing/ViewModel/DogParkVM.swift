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

        }
        fetchDogs()
    }
    
    
    func fetchDogs() {
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
}
