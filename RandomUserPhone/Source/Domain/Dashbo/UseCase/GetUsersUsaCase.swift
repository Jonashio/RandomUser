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
    let isPreview: Bool
    
    init(_ isPreview: Bool = false) {
        self.isPreview = isPreview
    }
    
    func execute(parameters: Codable) async -> Result<T, ErrorGeneric> {
        guard !isPreview else { return await executePreview() }
        guard let parametersRequest = parameters as? ListRequestDTO else { return .failure(.empty) }
        let resultResponse:Result<ListResponseDTO, NetworkError> = await NetworkGeneric().getData(profileEndpoint: .list(parametersRequest), builder: ListResponseDTO.builder())
        
        switch resultResponse {
        case .success(let model):
            return .success(ListUsers(users: model.results.compactMap({ User.builder($0) }) ))
        case .failure(let failure):
            return .failure(.general(failure))
        }
    }
    
    func executePreview() async -> Result<T, ErrorGeneric> {
        guard let model = LocalFileManager.loadPrivateFile(filename: "randomuser", ofType: "json", builder: ListResponseDTO.builder()) else { return .failure(.empty) }
        return .success(ListUsers(users: model.results.compactMap({ User.builder($0) }) ))
    }
}
