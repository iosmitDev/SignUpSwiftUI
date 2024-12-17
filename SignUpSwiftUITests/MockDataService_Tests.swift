//
//  MockDataService_Tests.swift
//  SignUpSwiftUITests
//
//  Created by MiteshKumar Patel on 17/12/24.
//

import XCTest
@testable import SignUpSwiftUI
import Combine

final class MockDataService_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }
    
    //Test Mock Data service seperately
    func test_MockDataService_init_doesSetValueCorrectly() {
        
        //Given
        let items:[String]? = nil
        let items2:[String]? = []
        let items3:[String]? = [UUID().uuidString, UUID().uuidString]
        
        //When
        let dataService = MockDataService(items: items)
        let dataService2 = MockDataService(items: items2)
        let dataService3 = MockDataService(items: items3)
        
        //Then
        // XCTAssertGreaterThan(dataService.items.count, 0)
        XCTAssertFalse(dataService.items.isEmpty) //It will have default value
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    
    //Test Mock Data service seperately
    func test_MockDataService_downloadItemsUsingEscapingClosure_shouldReturnsValues() {
        
        //Given
        let dataService = MockDataService(items: nil)
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsUsingEscapingClosure { returnedItems in
            items = returnedItems //Hold returnes items somewhere
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation],timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
    }
    
    func test_MockDataService_downloadItemsUsingCombine_shouldReturnsValues() {
        
        //Given
        let dataService = MockDataService(items: nil)
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsUsingCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables) //Removed all cancellable in teardown
        
        //Then
        wait(for: [expectation],timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
    }
    
    func test_MockDataService_downloadItemsUsingCombine_doesFail() {
        
        //Given
        let dataService = MockDataService(items: []) //Passed empty array so it throws error
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsUsingCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure:
                    expectation.fulfill()
                }
                
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables) //Removed all cancellable in teardown
        
        //Then
        wait(for: [expectation],timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
    }
}
