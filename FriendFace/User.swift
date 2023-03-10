//
//  User.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: Int
    var company: String
    var about: String
    var isActive: Bool
    var email: String
    var registered: Date
    var friends: [Friend]
    var address: String
    var tags: [String]
    
    
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}


