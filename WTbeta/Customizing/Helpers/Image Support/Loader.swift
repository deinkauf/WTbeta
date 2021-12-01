//
//  Loader.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/30/21.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseStorage

final class Loader : ObservableObject {
    
    @Published var data: Data?

    init(dog: Dog){
        // the path to the image
        let url = "images/\(dog.id ?? "").jpg"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
                if dog.imageData == nil {
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(Auth.auth().currentUser!.uid)
                    let collectionRef = userRef.collection("userDogs")
                    let dogDocRef = collectionRef.document(dog.id ?? "")
                    
                    dogDocRef.setData([
                        "imageData" : data
                    ], merge: true)
                }
            }
        }
    }
}
