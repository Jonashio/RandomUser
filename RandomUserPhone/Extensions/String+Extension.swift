//
//  String+Extension.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import Foundation

extension String: Identifiable {
    public var id: String {
        return self
    }
    
    var toFormatURL: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)?.replacingOccurrences(of: "+", with: "%2B") ?? replacingOccurrences(of: "+", with: "%2B")
    }
}
