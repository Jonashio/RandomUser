//
//  ListResponseDTO.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import Foundation

// MARK: - ListResponseDTO
struct ListResponseDTO: Codable {
    let results: [UserDTO]
    let info: InfoDTO
    
    static func builder() -> ((Data) throws -> ListResponseDTO) {
        { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            return try decoder.decode(ListResponseDTO.self, from: data)
        }
    }
}

// MARK: - Info
struct InfoDTO: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct UserDTO: Codable {
    let gender: String
    let name: NameDTO
    let location: LocationDTO
    let email: String
    let login: LoginDTO
    let dob, registered: DateYearsOldDTO
    let phone, cell: String
    let id: ID
    let picture: PictureDTO
    let nat: String
}

// MARK: - Dob
struct DateYearsOldDTO: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable {
    let name: String
    let value: String?
}

// MARK: - Location
struct LocationDTO: Codable {
    let street: StreetDTO
    let city, state, country: String
    let postcode: Postcode
    let coordinates: DTO
    let timezone: TimezoneDTO
}

// MARK: - Coordinates
struct DTO: Codable {
    let latitude, longitude: String
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Street
struct StreetDTO: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct TimezoneDTO: Codable {
    let offset, description: String
}

// MARK: - Login
struct LoginDTO: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct NameDTO: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct PictureDTO: Codable {
    let large, medium, thumbnail: String
}
