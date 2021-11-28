//
//  DogParkVM.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/23/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MapVM: ObservableObject {
    
    @Published var dogParks = [DogPark]()
    
    private var db = Firestore.firestore()
    
    init() {
        
    }
    
    func fetchData() {
        db.collection("dogParks").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.dogParks = documents.compactMap { (queryDocumentSnapshot) -> DogPark? in
                return try? queryDocumentSnapshot.data(as: DogPark.self)
            }
        }
    }
}
