//
//  UserPersistenceManager.swift
//  RandomUserPhone
//
//  Created by Jonashio on 29/11/23.
//

import SwiftData
import SwiftUI

final class UserPersistenceManager {
    static let shared = UserPersistenceManager()

    private init(){}
    
    func getUsers(_ context: ModelContext) -> [UserPersistenceModel] {
        do {
            let descriptor = FetchDescriptor<UserPersistenceModel>(sortBy: [SortDescriptor(\.name)])
            return try context.fetch(descriptor)
        } catch {
            return []
        }
    }
    
    func addUsers(_ listUsers: [User], context: ModelContext) -> Bool {
        listUsers.forEach({ context.insert(UserPersistenceModel.builder($0)) })
        return save(context)
    }
    
    func removeUsers(_ list: [User], context: ModelContext) -> Bool {
        list.forEach { user in
            guard let internalUser = getUsers(context).first(where: { $0.id.elementsEqual(user.id)}) else { return }
            context.delete(internalUser)
        }

        return save(context)
    }
    
    func removeUser(_ user: User, context: ModelContext) -> Bool {
        guard let internalUser = getUsers(context).first(where: { $0.id.elementsEqual(user.id)}) else { return false }
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
