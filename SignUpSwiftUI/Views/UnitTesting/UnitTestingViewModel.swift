//
//  UnitTestingViewModel.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 15/12/24.
//

import Foundation
import Combine

class UnitTestingViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    let dataService: DataServiceProtocol
    
    init(isPremium: Bool, dataService: DataServiceProtocol = MockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        
        //If value is not optional then direct use with Guard
        guard !item.isEmpty else { return}
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        
        if let x = dataArray.first(where: {$0 == item}) {
            selectedItem = x
        }
        else {
            selectedItem = nil
        }
        
    }
    //Saving item can throw error
    func saveItem(item: String) throws {
        
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let selectedItemValueExist = dataArray.first(where: {$0 == item}) {
            print("Save item here", selectedItemValueExist)
        }
        else {
            //If not found then
            throw DataError.itemNotFound
        }
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsUsingEscapingClosure { [weak self] returnedItems in
            self?.dataArray = returnedItems
        }
        
    }
    
    func downloadWithCombine(){
        //We have already set the data there
        dataService.downloadItemsUsingCombine()
            .sink { _ in
                
            } receiveValue: {[weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)
    }
    
    enum DataError: LocalizedError {        
        case itemNotFound
        case noData
    }
    
}
