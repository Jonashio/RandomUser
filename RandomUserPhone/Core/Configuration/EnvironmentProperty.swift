//
//  EnvironmentProperty.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import Foundation

class EnvironmentProperty {
    
    // MARK: - BASE ENDPOINTS
    static var keyUrlBase: String {
        Bundle.main.object(forInfoDictionaryKey: "KEY_URL_BASE") as? String ?? ""
    }
}
