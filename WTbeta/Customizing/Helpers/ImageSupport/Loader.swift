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
        let storage = Storage.storage()
        let ref = storage.reference().child(dog.imagePath ?? "")
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
                print("------------------ data : \(data)")
                print("---------------- self.data : \(self.data)")
            }
        }
    }
}
