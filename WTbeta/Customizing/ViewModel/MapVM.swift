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

class MapVM: ObservableObject {
    
    @Published var DogParks = [DogPark]()
    
    init() {
        DogParks.append(DogPark(name: "University Dog Park"))
        DogParks.append(DogPark(name: "College Station Dog Park"))
        DogParks.append(DogPark(name: "Little Elm Dog Park"))
    }
    
    func AddDogPark(){
        DogParks.append(DogPark(name: "New Dog Park"))
    }
    
    //Create function that pulls the dogparks from the DB, converts them into VM objects, and stores them into the "DogParks" Array
    func getDogParks(){
        
        //create DB instance and pull dogPark collection
        let db = Firestore.firestore()
        let dpCol = db.collection("dogParks")

        //get documents from the collection
        dpCol.getDocuments { snapshot, error in

            //check for error
            guard error == nil && snapshot != nil else {
                return
            }
            
            // create an array of DogParks
            var dogParks = [DogPark]()

            // iterate through each document returned
            for doc in snapshot!.documents {

                //create a new dogPark instance
                var dp = DogPark()

                //parse out values into the dogpark instance
                dp.id = doc["id"] as? String ?? UUID().uuidString
                dp.name = doc["name"] as? String ?? ""
                dp.location = doc["location"] as? GeoPoint
                dp.dogsCheckedIn = doc["dogsCheckedIn"] as? [String] ?? [String]()

                //add it to our array
                dogParks.append(dp)

                // Assign dogparks to published property
                DispatchQueue.main.async{

                    self.DogParks = dogParks
                }
            }
        }
    }
    
}
