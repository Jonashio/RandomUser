//
//  ErrorGeneric.swift
//  RandomUser
//
//  Created by Jonashio on 28/11/23.
//

import Foundation

public enum ErrorGeneric:Error {
    case general(Error)
    case empty
}
