//
//  GetUsersUseCaseTest.swift
//  RandomUserPhoneTests
//
//  Created by Jonashio on 30/11/23.
//

import XCTest
@testable import RandomUserPhone

final class GetUsersUseCaseTest: XCTestCase {
    
    private var sut: GetUsersUseCase!
    private var repository: NetworkGeneric!
    
    override func setUp() {
        repository = NetworkGeneric(predefinedDataTest: LocalFileManager.loadPrivateFile(filename: "randomuser", ofType: "json"))
        sut = GetUsersUseCase(repository: repository)
    }
    
    func test_Given_execute() async {
        // When
        let randomParameters: ListRequestDTO = .init(results: 10, page: 0, seed: nil)
        let result = await sut.execute(parameters: randomParameters)
        
        // Then
        if case .success = result {
            XCTAssert(true, "Success load data in GetUsersUseCase.execute")
        }else{
            XCTFail("Expected that GetUsersUseCase.execute to be success")
        }
    }
    
    // TODO: Test Error
    func test_Given_Error_execute() async {
        // When
        repository.predefinedDataTest = Data()
        let randomParameters: ListRequestDTO = .init(results: 10, page: 0, seed: nil)
        let result = await sut.execute(parameters: randomParameters)
        
        // Then
        if case .failure = result {
            XCTAssert(true, "Success load WRONG data in GetUsersUseCase.execute")
        }else{
            XCTFail("Expected that GetUsersUseCase.execute to be error")
        }
    }
}
