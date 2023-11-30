//
//  RandomUserViewModel.swift
//  RandomUser
//
//  Created by Jonashio on 27/11/23.
//

import SwiftUI
import SwiftData

@Observable class DashboUsersViewModel {
    
    // MARK: - Properties
    var users: [User] = []
    var pagesLoaded = 0
    var status: Status = .idle
    var context: ModelContext?
    var userSelected: User?
    
    // MARK: - Private Properties
    private let useCase: GetUsersUseCase
    private var blacklist: [User] = []
    private var searchText = ""
    private var temporalUserList: [User] = []
    
    
    init(useCase: GetUsersUseCase) {
        self.useCase = useCase
    }

    @Sendable func fetchData() async {
        self.context = context
        status = .loading
        
        let response = await useCase.execute(parameters: buildParamsDTO())
        
        switch response {
        case .success(let model):
            updateViewData(newUsers: model.users)
        default:
            status = .error
        }
    }
    
    func loadSavedData(_ context: ModelContext) {
        self.context = context
        withAnimation {
            users = UserPersistenceManager.shared.getUsers(context).map({ User.builder($0) })
        }
    }
    
    func doPagination(_ user: User) {
        guard status != .loading && searchText.isEmpty else { return }
        guard users.last?.id.elementsEqual(user.id) ?? false else { return }
        
        Task { await fetchData() }
    }
    
    func doRemove(_ indexSet: IndexSet) {
        guard let context = context else { return }
        let usersToDelete = indexSet.map { self.users[$0] }
        
        _ = UserPersistenceManager.shared.removeUsers(usersToDelete, context: context)
        
        withAnimation {
            users.remove(atOffsets: indexSet)
            blacklist.append(contentsOf: usersToDelete)
        }
        
    }
    
    func doFilter(_ text: String) {
        guard !searchText.elementsEqual(text) else { return }
        
        searchText = text
        
        if searchText.isEmpty {
            users = temporalUserList
            temporalUserList.removeAll()
        }else{
            temporalUserList.isEmpty ? temporalUserList = users : ()
            users = temporalUserList.filter({ filterUser in
                return filterUser.name.lowercased().contains(searchText.lowercased()) ||
                filterUser.email.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    func doSelectUser(_ user: User?) {
        withAnimation { userSelected = user }
    }
}

extension DashboUsersViewModel {
    
    private func updateViewData(newUsers: [User]) {
        guard let context = context else { return }
        let filter = newUsers.filter({ filterUser in
            !users.contains(where: { $0.id.elementsEqual(filterUser.id)}) && !blacklist.contains(where: { $0.id.elementsEqual(filterUser.id)})
        })
        
        _ = UserPersistenceManager.shared.addUsers(filter, context: context)
        
        withAnimation {
            pagesLoaded += 1
            users.append(contentsOf: filter)
            status = .idle
        }
    }
    
    private func buildParamsDTO() -> ListRequestDTO {
        ListRequestDTO(results: Constants.RequestUser.sizeUsersPerPage, page: pagesLoaded, seed: nil)
    }
    
}
