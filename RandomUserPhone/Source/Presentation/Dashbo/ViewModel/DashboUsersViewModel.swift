//
//  RandomUserViewModel.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import Foundation

@Observable class DashboUsersViewModel {
    
    var users: [User] = []
    var pagesLoaded = 0
    var status: Status = .normal
    
    
    @Sendable func fetchData() async {
        status = .loading
        var response = await GetUsersUseCase().execute(parameters: buildParamsDTO())
        switch response {
        case .success(let model):
            pagesLoaded += 1
            users.append(contentsOf: model.users)
            status = .normal
        default:
            status = .error
        }
    }
    
    private func buildParamsDTO() -> ListRequestDTO {
        return ListRequestDTO(results: Constants.RequestUser.sizeUsersPerPage, page: pagesLoaded, seed: Constants.RequestUser.seed)
    }
}
