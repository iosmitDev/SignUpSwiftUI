//
//  ActorsTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 24/11/24.
//

import SwiftUI

//Problem? => Data race problem, 2 diffrent thread access same resources/object in memory
  // 1) Recreate problem => Create a singleton class and create function
 // call this function in 2 diffrent class with same timer, enable thread sanitiser , so data race created
//Solution without actor => Create dispatchqueue custom in singlton class and use queue.async{ code } so it will execute one by one
//Solution with actor => replace whole class with actor and done
//We have to use await before calling this that's done


//We have shared data manager
class HTTPDataManager {
    
    func fetchDataFromAPI() -> [String] {
        
        return ["hello", "Mitesh", "patel"]
    }
}

//We have View model
class ActorTestViewModel: ObservableObject {
    
    //Created aray of strings
    @Published var dataArray: [String] = []
    
    //Create object of shared data manager
    let manager = HTTPDataManager()
    
    func getAPIData() async {
        
       let result = manager.fetchDataFromAPI()
        self.dataArray = result
    }
}

//We have a view
struct ActorsTest: View {
    
    //Create View Model object
    @StateObject var vm = ActorTestViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task { //It is running on MainActor
                await vm.getAPIData()
            }
    }
}

#Preview {
    ActorsTest()
}
