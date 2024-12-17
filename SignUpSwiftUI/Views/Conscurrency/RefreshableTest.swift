//
//  RefreshableTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 27/11/24.
//

import SwiftUI

@globalActor final class DataManager {
    
    static var shared = RefreshableDataManager()
       
}

//We will use actor or final class for RefreshableDataService
actor RefreshableDataManager {
     
}

final class RefreshableDataService {
    
    func getData() async throws -> [String] {
        //Here we want to sleep for 2 second that data changed
        //Task.sleep await for 2 seconds and it can throw error
        //Like api call and response fake with task sleep
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return ["hellp","call","tesls","toasts"].shuffled()
    }
}

//View model class is final and 
// We have added @MainActor so it reminds to add mainthread
@MainActor
final class RefreshableViewModel: ObservableObject {
    
    let manager = RefreshableDataService()
    
    @Published private(set) var dataArray: [String] = [] //Need from Manager
    @Published var image: UIImage? = nil
    
    func getRefreshable() async {
        
        //It is async call so we need to use task and await
        
            do {
                dataArray = try await manager.getData()
            }
            catch {
                print("\(error)", terminator: " ")
            }
       
    }
    
}


struct RefreshableTest: View {
    
    @StateObject private var vm = RefreshableViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(vm.dataArray, id: \.self) {
                        Text($0)
                            .font(.headline)
                    }
                    
                }
            }
            .refreshable {
               await vm.getRefreshable()
            }
            .navigationTitle("Refreshable")
            .task {
                await vm.getRefreshable()
            }
        }
        
    }
}

#Preview {
    RefreshableTest()
}
