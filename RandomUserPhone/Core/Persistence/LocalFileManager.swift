//
//  LocalFileManager.swift
//  RandomUserPhone
//
//  Created by Jonashio on 28/11/23.
//

import Foundation

struct LocalFileManager {
    static func loadPrivateFile(filename: String, ofType: String) -> Data? {
        guard let path = Bundle.main.path(forResource: filename, ofType: ofType) else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    static func loadPrivateFile<Type>(filename: String, ofType: String, builder: ((Data) throws -> Type)) -> Type? {
        guard let data = loadPrivateFile(filename: filename, ofType: ofType) else { return nil }
        return try? builder(data)
    }
}
