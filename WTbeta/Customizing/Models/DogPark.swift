//
//  DogPark.swift
//  WTbeta
//
//  Created by Mason Hendry on 11/23/21.
//
///TODO
///Figure out how to store in GeoPoint format

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DogPark: Identifiable, Codable {
    @DocumentID var id = UUID().uuidString
    var name: String?
    var location: GeoPoint?
    var dogsCheckedIn = [String]()
}
