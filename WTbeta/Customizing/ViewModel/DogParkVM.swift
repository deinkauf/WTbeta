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
    
    var dog: Dog = Dog()
    
    init(){
        
    }
    
//    func getDogData(dogId: String) {
//        let db = Firestore.firestore()
//        let dogDoc = db.collection("dogs").document(dogId)
//        dogDoc.getDocument { document, error in
//            if let error = error as NSError? {
//                self.errorMessage = "Error getting document: \(error.localizedDescription)"
//            }
//            else
//            {
//                if let document = document {
//                    do {
//                        self.dog = try document.data(as: Dog.self)
//                    }
//                    catch {
//                        print(error)
//            }
//          }
//        }
//      }
//    }
}
