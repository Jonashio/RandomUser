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
    let street: String
    let city: String
    let country: String
    
    init(id: String,
         name: String,
         gender: String,
         email: String,
         phone: String,
         imgLarge: String,
         imgMedium: String,
         thumbnail: String,
         street: String,
         city: String,
         country: String) {
        self.id = id
        self.name = name
        self.gender = gender
        self.email = email
        self.phone = phone
        self.imgLarge = imgLarge
        self.imgMedium = imgMedium
        self.thumbnail = thumbnail
        self.street = street
        self.city = city
        self.country = country
    }
    
    static func builder(_ model: User) -> UserPersistenceModel {
        UserPersistenceModel(id: model.id,
                             name: model.name,
                             gender: model.gender.rawValue,
                             email: model.email,
                             phone: model.phone,
                             imgLarge: model.picture.large,
                             imgMedium: model.picture.medium,
                             thumbnail: model.picture.thumbnail,
                             street: model.detail.street,
                             city: model.detail.city,
                             country: model.detail.country)
    }
}
