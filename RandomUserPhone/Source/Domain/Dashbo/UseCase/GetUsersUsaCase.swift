//
//  GetUsersUsaCase.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import Foundation


protocol UseCase {
    associatedtype T
    func execute(parameters: Codable) async -> Result<T, ErrorGeneric>
}

struct GetUsersUseCase: UseCase {
    typealias T = ListUsers
    
    func execute(parameters: Codable) async -> Result<T, ErrorGeneric> {
        guard let parametersRequest = parameters as? ListRequestDTO else { return .failure(.empty) }
        let resultResponse:Result<ListResponseDTO, NetworkError> = await NetworkGeneric().getData(profileEndpoint: .list(parametersRequest), builder: ListResponseDTO.builder())
        
        switch resultResponse {
        case .success(let model):
            let listUsers = ListUsers(users: model.results.compactMap({ userDTO in
                guard let id = UUID(uuidString: "") else { return nil }
                return User(id: id, name: userDTO.name.first + userDTO.name.last, gender: .build(rawValue: userDTO.gender))
            }) )
            
            return .success(listUsers)
        case .failure(let failure):
            return .failure(.general(failure))
        }
    }
}
