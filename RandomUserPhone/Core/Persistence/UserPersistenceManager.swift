//
//  UserManager.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import SwiftData
import SwiftUI

final class UserPersistenceManager {
    static let shared = UserPersistenceManager()
    
    @Query var users: [UserPersistenceModel]
    
    private init(){}
    
    func addUsers(_ listUsers: [User], context: ModelContext) -> Bool {
        listUsers.forEach({ context.insert(UserPersistenceModel.builder($0)) })
        return save(context)
    }
    
    func removeUser(_ user: User, context: ModelContext) -> Bool {
        guard let internalUser = users.first(where: { $0.id.elementsEqual(user.id)}) else { return false }
        context.delete(internalUser)
        return save(context)
    }
    
    private func save(_ context: ModelContext) -> Bool {
        do{
            try context.save()
            return true
        }catch{ return false }
    }
}
