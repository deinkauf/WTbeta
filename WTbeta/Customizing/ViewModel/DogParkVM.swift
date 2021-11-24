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
    
    @Published var updateUI = false
    
    init(){
        
    }
    
//    func fetchDogParkData(dogParkId: String) {
//        // fetch all data from firestore doc using given Dog Park ID
//        let db = Firestore.firestore()
//        let dpRef = db.collection("dogParks").document(dogParkId)
//        dpRef.getDocument { document, error in
//            self.dogPark = try document?.data(as: DogPark.self)
//        }
//    }
    
    func fetchDogParkData(dogParkID: String) {
        let db = Firestore.firestore()
      let docRef = db.collection("dogParks").document(dogParkID)
      docRef.getDocument { document, error in
        if let error = error as NSError? {
          print(error)
        }
        else {
          if let document = document {
            do {
              self.dogPark = try document.data(as: DogPark.self)
            }
            catch {
              print(error)
            }
          }
        }
      }
        self.updateUI.toggle()
    }
}
