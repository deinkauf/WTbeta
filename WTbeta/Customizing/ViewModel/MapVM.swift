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
import Combine
import MapKit

// TODO -- make function to fill this array with dog parks from db based on location criteria


//class MapVM: ObservableObject {
//
//    @Published var dogParks = [DogPark]()
//
//    init() {
//
//    }
//
//    func fetchData() {
//        let db = Firestore.firestore()
//        db.collection("dogParks").addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else {
//                print("no documents")
//                return
//            }
//
//            self.dogParks = documents.compactMap { (queryDocumentSnapshot) -> DogPark? in
//                return try? queryDocumentSnapshot.data(as: DogPark.self)
//            }
//        }
//    }
//}

// delegate keeps track of changes
class MapVM: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.6280, longitude: -96.3344),
                                               span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    // array of dogparks from map search
    @Published var dogParkSearchResults = [DogPark]()
    
    // array of dogparks to display on map
    @Published var dogParks = [DogPark]()

    var locationManager: CLLocationManager?

    // check if user's iPhone's location services is enabled
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self // sets the delegate to use delegate's function
        } else {
            print("show alert that locations services is off. needs to be turned on")
        }
    }

    // check if app has permission for location
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("show alert: location is restricted. need to unrestrict to use")
        case .denied:
            print("show alert: location is denied. need to grant access to use.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            searchForDogParksNearUser()
            // then to actually display these on the map, we will pull from firestore.
            // that way, we can control the distance, how many dog parks to display,
            // and also display dogparks that were added that arent on apple maps
        @unknown default:
            break
        }
    }

    // delegate notifies when authorization is changed, and function checks the new status
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func searchForDogParksNearUser() {
        // runs MKLocalSearch to find dogparks near user, creates a dogParkModel of them, and adds them to our Main realm data list of dogparks

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "dog park"
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        search.start { [self] response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                print("------hash value = \(String(item.hashValue))")
                let dogPark = DogPark(id: String(item.hashValue), name: item.name, location: GeoPoint(latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude))
                dogParkSearchResults.append(dogPark)
            }

            print("--------dogParksDemo list test---------")
            for item in dogParkSearchResults {
                print(item)
            }
        }
//        addDogParksToDB()
    }
    
    func addDogParksToDB() {
        let db = Firestore.firestore()
        for dogPark in dogParkSearchResults {
            print("dogpark id is : \(dogPark.id)")
            guard dogPark.id != nil else { return }
            try? db.collection("dogParks").document(dogPark.id!).setData(from: dogPark, merge: true)
        }
//        fetchDogParks()
    }
    
    func fetchDogParks() {
        // just show searched dog parks for now
        for dogPark in dogParkSearchResults {
            dogParks.append(dogPark)
        }
        
        // eventually this will pull dogparks based on user's relative location
        
//        let db = Firestore.firestore()
//        db.collection("dogParks").addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else {
//                print("no documents")
//                return
//            }
//
//            self.dogParks = documents.compactMap { (queryDocumentSnapshot) -> DogPark? in
//                return try? queryDocumentSnapshot.data(as: DogPark.self)
//            }
//        }
    }
    
    func distanceFromUser(dogParkLocation: GeoPoint) {
        // -- this will compare the latitude and longitude of the dogpark to the user's location
        //    and calculate the distance between the two -> returning a boolean true if the distance is < our decided distance
    }
    
    
}
