//
//  AsyncStreamTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 29/11/24.
//

import SwiftUI

class AsyncStreamDataManager {
    
    //AsyncStream is generic and publish Any type of data
    //AsyncStream<Any> => AsyncStream<Int> retrun Integer here
    //AsyncThrowingStream <type, error>
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        
        //Type of Int returing as element
        //Elemement Type => Return type => Int.self
        
//        AsyncStream(Int.self) { [weak self] continuation in
//            self?.getFakeDataFromAsyncStream { value in
//                continuation.yield(value)
//            }
//         onFinish: {
//            continuation.finish()
//            }
//        }        
       
        AsyncThrowingStream { continuation in
            
            self.getFakeDataFromAsyncStream { value in
                
                continuation.yield(value)
                
            } onFinish: { error in
                
                if let error {
                    continuation.finish(throwing: error)
                }
                else {
                    continuation.finish()
                }
            }

        }
        
    }
    
    //return data from server completion handler
    //Create receive value and error handler
    func getFakeDataFromAsyncStream(completion: @escaping (_ value: Int) -> Void, onFinish: @escaping (_ error: Error?) -> Void)  {
      
        //Create array of int
        let items: [Int] = [1,2,4,5,6,3,7,8,9,10]
        
        //for in Loop
        for item in items {
            //It will add double time after +
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                
                //Compeltion has value
                completion(item)
                
                if item == items.last {
                    //error is nil if item is last then finish
                    onFinish(nil)
                }
            })
        }
    }
    
}
@MainActor final class AsyncStreamViewModel: ObservableObject {
    let manager = AsyncStreamDataManager()
    @Published private(set) var count: Int = 0 //Initial count 0
    
    func onViewAppear() {
        
//        //Call completion handler and get response
//        manager.getFakeDataFromAsyncStream { [weak self] value in
//            self?.count = value
//        }
//        Task {
//            for await value in manager.getAsyncStream() {
//                self.count = value
//            }
//        }
        Task {
            
            do {
                for try await value in manager.getAsyncStream(){
                    self.count = value
                }
            }
            catch {
                print(error)
            }
        }
    }
}

struct AsyncStreamTest: View {
    
    @StateObject private var vm = AsyncStreamViewModel()
    var body: some View {
        Text("\(vm.count)")
            .onAppear(){
                vm.onViewAppear()
            }
    }
}

#Preview {
    AsyncStreamTest()
}

