//
//  Dog.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/20/21.
//
/// TODO
/// Double check proifile pic data type

import Foundation
import FirebaseFirestoreSwift

class Dog: Identifiable, Codable {
    @DocumentID var id = UUID().uuidString
    var name: String?
    var breed: String?
    var bio: String?
    var age: Int?
    var cardColor: CardColor?
    var profilePic: Data?
    var checkedIn: Bool?
    var ownerID: String?
}

enum CardColor: Codable {
    case red
    case yellow
    case green
}

