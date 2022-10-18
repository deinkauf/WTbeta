//
//  User.swift
//  WTbeta
//
//  Created by Donovan Einkauf on 11/19/21.
//

import Foundation
import FirebaseFirestoreSwift


class User: Codable {
    @DocumentID var id = UUID().uuidString
    var name: String?
    var userName: String?
    var defaultDogParkID: String?
}
