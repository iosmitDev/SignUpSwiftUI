//
//  MockDataService.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 17/12/24.
//

import Foundation
import SwiftUI
import Combine

protocol DataServiceProtocol {
    
    func downloadItemsUsingEscapingClosure(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsUsingCombine() -> AnyPublisher<[String], Error>
}


//This service for Development and test purpose
class MockDataService: DataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) { //Provided optional to pass nil value
        self.items = items ?? ["One", "Two", "Three"] //Assigned if nil found then
    }
    
    func downloadItemsUsingEscapingClosure(completion: @escaping (_ items: [String]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            
            completion(self.items)
        })
         
    }
    
    //Publisher has result => Arrayof String and Error
    func downloadItemsUsingCombine() -> AnyPublisher<[String], Error> {
      
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
    
}
