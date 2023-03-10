//
//  User.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import Foundation

struct User: Codable {
    let name: String
    let age: Int
    let company: String
    let about: String
    let isActive: Bool
    let emailAddress: String
    let registered: Date
    let friends: [Friend]
}

struct Friend: Codable {
    let id: String
    let name: String
}


