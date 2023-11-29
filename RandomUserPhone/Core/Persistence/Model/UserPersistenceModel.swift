//
//  UserPersistenceModel.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import SwiftData

@Model
class UserPersistenceModel {
    @Attribute(.unique) let id: String
    let name: String
    let gender: String
    let email: String
    let phone: String
    let imgLarge: String
    let imgMedium: String
    let thumbnail: String
    
    init(id: String, name: String, gender: String, email: String, phone: String, imgLarge: String, imgMedium: String, thumbnail: String) {
        self.id = id
        self.name = name
        self.gender = gender
        self.email = email
        self.phone = phone
        self.imgLarge = imgLarge
        self.imgMedium = imgMedium
        self.thumbnail = thumbnail
    }
}
