//
//  SignUpSwiftUI_Tests.swift
//  SignUpSwiftUITests
//
//  Created by MiteshKumar Patel on 15/12/24.
//

import XCTest
@testable import SignUpSwiftUI
import Combine

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure: test_[Struct or class]_[variable or function]_[Expected Result]

// Testing Structure: Given When Then

// Import target of our app so we can access the class method: @testable import AppName


final class SignUpSwiftUI_Tests: XCTestCase {
    
    //Create ViewModel istance globally so we create variable of VM and then assign in setup
    var viewModel: UnitTestingViewModel?
    
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        //This method called before testcase execution
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil //Clear the value
    }
       
    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        
        //Given => If this value passed for future or given for future
        let userIsPremium: Bool = true
        
        //When => when we setup our viewmodel
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then => Check expected result behaviour
        XCTAssertTrue(vm.isPremium)
        
    }
    
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        
        //Given => If this value passed for future or given for future
        let userIsPremium: Bool = false
        
        //When => when we setup our viewmodel
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then => Check expected result behaviour
        XCTAssertFalse(vm.isPremium)
        
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        
        //Given => If this value passed for future or given for future
        let userIsPremium: Bool = Bool.random()
        
        //When => when we setup our viewmodel
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then => Check expected result behaviour
        XCTAssertEqual(vm.isPremium, userIsPremium)
        
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_stress() {
        //Stress test
        for _ in 0..<10 { //Loop 100 times to test random value
            
            //Given => If this value passed for future or given for future
            let userIsPremium: Bool = Bool.random()
            
            //When => when we setup our viewmodel
            let vm = UnitTestingViewModel(isPremium: userIsPremium)
            
            //Then => Check expected result behaviour
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
        
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
        
        //Given
        //As per expected result we dont need given, we just check so used in Then
        
        //When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItems() {
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
            
        }
        //let item = "Hello"
        //let item = UUID().uuidString
        //vm.addItem(item: item)
        
        //Then
        // XCTAssertEqual(vm.dataArray.first, "Hello")
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        // XCTAssertLessThan(vm.dataArray.count, 2)
        //  XCTAssertLessThanOrEqual(vm.dataArray.count, 1, "Count is 1")
        // XCTAssertGreaterThanOrEqual(vm.dataArray.count, 2, "It should be 1")
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString() {
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        let item = ""
        vm.addItem(item: item)
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString2() {
        
        //Given
        //When => when we setup our viewmodel
        guard let vm = viewModel else {
            XCTFail() //If Viewmodel not available then it retun and product xctFail error
            return
        }
        
        //When
        let item = ""
        vm.addItem(item: item)
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        //First assigned nil
        
        //Given
        
        //When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertNil(vm.selectedItem)
        XCTAssertTrue(vm.selectedItem == nil)
        
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        //First assigned nil
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertNil(vm.selectedItem)
        
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        var tempArray: [String] = []
        let loopCount = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount{
            
            let item = UUID().uuidString
            vm.addItem(item: item)
            tempArray.append(item)
        }
        let randomItem = tempArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: "")) { error in
            let error = error as? UnitTestingViewModel.DataError
            
            XCTAssertEqual(error, UnitTestingViewModel.DataError.noData)
        }
        
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        do {
            try vm.saveItem(item: UUID().uuidString)
        } catch let error {
            let error = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(error, UnitTestingViewModel.DataError.itemNotFound)
        }
        
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveItem() {
        
        //Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1..<100)
        var itemArray:[String] = []
        
        for _ in 0..<loopCount {
            let item = UUID().uuidString
            vm.addItem(item: item)
            itemArray.append(item)
            
        }
        let item = itemArray.randomElement() ?? ""
        XCTAssertFalse(item.isEmpty) //If item is empty then it shoud use XCTAssertFalse()
        
        //Then
        XCTAssertNoThrow(try vm.saveItem(item: item))
        
        //Then
        do {
            try vm.saveItem(item: item)
        } catch {
            XCTFail()
        }
    }
        
    // Test Escaping closure => We should wait till return call => it is async call
    // First create expectation object of => XCTestExpectation => Add description like => "Should return items after 3 seconds."
    // Expectation should be fulfill => Write combine code/ any other code where write => expectation.fulfill()
    // Wait for expectation => wait(for:XCTestExpectation ,timeout: 5) => we will wait till for this timeout
    
    func test_UnitTestingViewModel_downloadWithEscaping_shouldReturnedItems() {
        
        //Given => we have Viewmodel
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When => When we call Viewmodel with downloadWithEscaping
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        vm.$dataArray
            .dropFirst() //When we call it has blank array then it will publish but we dont want on blank afterward any update then publish
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        vm.downloadWithEscaping()
        
        //Then => It should return below
        wait(for: [expectation], timeout: 5) //Wait before we assert
        XCTAssertGreaterThan(vm.dataArray.count, 0)
      
    }
    
    
    func test_UnitTestingViewModel_downloadWithCombine_shouldReturnedItems() {
        
        //Given => we have Viewmodel
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When => When we call Viewmodel with downloadWithEscaping
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        vm.$dataArray
            .dropFirst() //When we call it has blank array then it will publish but we dont want on blank afterward any update then publish
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        vm.downloadWithCombine()
        
        //Then => It should return below
        wait(for: [expectation], timeout: 5) //Wait before we assert
        XCTAssertGreaterThan(vm.dataArray.count, 0)
      
    }
}
