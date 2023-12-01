//
//  DashboUsersViewModelTest.swift
//  RandomUserPhoneTests
//
//  Created by Jonashio on 1/12/23.
//

import XCTest
import SwiftData
@testable import RandomUserPhone

class DashboUsersViewModelTest: XCTestCase {
    private var sut: DashboUsersViewModel!
    private var usersUseCase: GetUsersUseCase!
    private var repository: NetworkGeneric!
    
    func test_success_load_data() async {
        // When
        await createSut()
        await sut.fetchData()
        
        // Then
        XCTAssertEqual(sut.status, .idle)
    }
    
    func test_failure_load_data() async {
        // When
        createWrongSut()
        await sut.fetchData()
        
        // Then
        XCTAssertEqual(sut.status, .error)
    }
    
    func test_remove_user() async {
        // When
        await createSut()
        await sut.fetchData()
        
        let currentlyUserCount = sut.users.count
        sut.doRemove(.init([0]))
        
        // Then
        XCTAssertEqual(sut.users.count, currentlyUserCount - 1)
    }
    
    func test_filter_users() async {
        // When
        await createSut()
        await sut.fetchData()
        
        let currentlyUserCount = sut.users.count
        sut.doFilter("AN")
        
        // Then
        XCTAssertNotEqual(sut.users.count, currentlyUserCount)
    }
    
    func test_filter_empty() async {
        // When
        await createSut()
        await sut.fetchData()
        
        sut.doFilter("asdfasd23432jasdfjwe")
        
        // Then
        XCTAssertEqual(sut.users.count, 0)
    }
    
    private func createSut() async {
        repository = NetworkGeneric(predefinedDataTest: LocalFileManager.loadPrivateFile(filename: "randomuser", ofType: "json"))
        usersUseCase = GetUsersUseCase(repository: repository)
        sut = DashboUsersViewModel(useCase: usersUseCase)
        sut.context = try? await ModelContainer(for: UserPersistenceModel.self).mainContext
    }
    
    private func createWrongSut() {
        repository = NetworkGeneric(predefinedDataTest: Data())
        usersUseCase = GetUsersUseCase(repository: repository)
        sut = DashboUsersViewModel(useCase: usersUseCase)
    }
}
