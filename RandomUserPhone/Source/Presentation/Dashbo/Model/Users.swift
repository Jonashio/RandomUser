//
//  Users.swift
//  RandomUser
//
//  Created by Jonashio on 28/11/23.
//

import Foundation


struct ListUsers {
    let users: [User]
}

struct User: Identifiable {
    let id: UUID
    let name: String
    let gender: Gender
}

enum Gender: String {
    case female = "female"
    case male = "male"
    case unknow = "unknow"
    
    static func build(rawValue: String) -> Gender {
        return Gender(rawValue: rawValue) ?? .unknow
    }
}
