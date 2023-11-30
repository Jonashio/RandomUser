//
//  LocalFileManager.swift
//  RandomUserPhone
//
//  Created by Jonashio on 28/11/23.
//

import Foundation

struct LocalFileManager {
    static func loadPrivateFile<Type>(filename: String, ofType: String, builder: ((Data) throws -> Type)) -> Type? {
        guard let path = Bundle.main.path(forResource: filename, ofType: ofType) else { return nil }
        do{
            return try builder(try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe))
        }catch {
            print(error)
            return nil
        }
    }
}
