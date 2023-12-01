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
    let repository: NetworkGeneric
    
    init(repository: NetworkGeneric = NetworkGeneric()) {
        self.repository = repository
    }
    
    func execute(parameters: Codable) async -> Result<T, ErrorGeneric> {
        guard let parametersRequest = parameters as? ListRequestDTO else { return .failure(.empty) }
        let resultResponse:Result<ListResponseDTO, NetworkError> = await repository.getData(profileEndpoint: .list(parametersRequest), builder: ListResponseDTO.builder())
        
        switch resultResponse {
        case .success(let model):
            return .success(ListUsers(users: model.results.compactMap({ User.builder($0) }) ))
        case .failure(let failure):
            return .failure(.general(failure))
        }
    }
}
