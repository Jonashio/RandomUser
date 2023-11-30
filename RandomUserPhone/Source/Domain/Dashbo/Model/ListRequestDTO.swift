//
//  ListRequestDTO.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import Foundation

struct ListRequestDTO: Codable {
    let results: Int
    let page: Int
    let seed: String?
}
