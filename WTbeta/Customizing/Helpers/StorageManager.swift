//
//  StorageManager.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/29/21.
//
///TODO
///Configure child reference path to specified folder & image name in the Firebase Storage App

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class StorageManager: ObservableObject {
    
    let storage = Storage.storage()
    
    func upload(image: UIImage, dogID: String) {
        // Create a storage reference
        let storageRef = storage.reference().child("images/\(dogID).jpg")
        
        // Resize the image to 200px with a custom extension
        let resizedImage = image.aspectFittedToHeight(200)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.2)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
    
    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // List all items in the images folder
        storageRef.listAll { (result, error) in
          if let error = error {
            print("Error while listing all files: ", error)
          }

          for item in result.items {
            print("Item in images folder: ", item)
          }
        }
    }

    //display photo
    func listItem(dogID: String) {
        // Create a reference
        let storageRef = storage.reference().child("images/\(dogID).jpg")
        print("--------------------------")
        print("Storage Reference: ",storageRef)
        print("--------------------------")

        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }

            let item = result.items
            print("item: ", item)
        }

        // List the items
        print("storage ref list: ")
        storageRef.list(maxResults: 1, completion: handler)
        print("--------------------------------------------")
    }

    // You can use the listItem() function above to get the StorageReference of the item you want to delete
    func deleteItem(dogID: String) {
        //Create a reference
        let storageRef = storage.reference().child("images/\(dogID).jpg")
        
        storageRef.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}
