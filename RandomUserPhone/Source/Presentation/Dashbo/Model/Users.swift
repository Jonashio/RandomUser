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
    let id: String
    let name: String
    let gender: Gender
    let email: String
    let phone: String
    let picture: Picture
    let detail: UserDetail
    
    static func fakeItem() -> Self {
        User(id: UUID().uuidString,
             name: "Fake",
             gender: .male,
             email: "test@google.com",
             phone: "555777888",
             picture: .init(large: "https://randomuser.me/api/portraits/men/68.jpg",
                            medium: "https://randomuser.me/api/portraits/med/men/68.jpg",
                            thumbnail: "https://randomuser.me/api/portraits/thumb/men/68.jpg"),
             detail: .init(street: "Bağdat Cd", city: "Karabük", country: "Turkey")
        )
    }
    
    static func builder(_ model: UserPersistenceModel) -> Self {
        User(id: model.id,
             name: model.name,
             gender: .build(rawValue: model.gender),
             email: model.email,
             phone: model.phone,
             picture: .init(large: model.imgLarge, medium: model.imgMedium, thumbnail: model.thumbnail),
             detail: .init(street: model.street, city: model.city, country: model.country))
    }
    
    static func builder(_ model: UserDTO) -> Self {
        User(id: model.login.uuid,
             name: model.name.first + model.name.last,
             gender: .build(rawValue: model.gender),
             email: model.email,
             phone: model.phone,
             picture: .builder(dto: model.picture),
             detail: .init(street: model.location.street.name, city: model.location.city, country: model.location.country))
    }
}

struct UserDetail {
    let street: String
    let city: String
    let country: String
}

struct Picture {
    let large, medium, thumbnail: String
    
    static func builder(dto: PictureDTO) -> Self {
        Picture(large: dto.large,
                medium: dto.medium,
                thumbnail: dto.thumbnail)
    }
    
}

enum Gender: String {
    case female = "female"
    case male = "male"
    case unknow = "unknow"
    
    static func build(rawValue: String) -> Gender {
        return Gender(rawValue: rawValue) ?? .unknow
    }
    
    func getNameIcon() -> String {
        switch self {
        case .female:
            return Constants.UserCell.female
        default:
            return Constants.UserCell.male
        }
    }
}
