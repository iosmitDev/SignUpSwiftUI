//
//  StrongSelfTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 28/11/24.
//

import SwiftUI

final class DataManagerClass {
        
    func getAPIData() async -> String {
        
        return "Welcome New"
    }
    
}

@MainActor
final class StrongSelfTestViewModel: ObservableObject {
    
    @Published private(set) var data: String = "Welcome"
    //Task hase Success void and failed never
   var someTask: Task<Void, Never>? = nil
    
    //Create blank Task array
    var taskArray: [Task<Void, Never>] = []
    
    let manager = DataManagerClass()
    
    func cancelTask() {
        //Cancle task
        someTask?.cancel() //Current running task cancel
        someTask = nil //Make it nil
        
        //Array one by one value applies then use foreach
        //It provided each object of array one by one
        taskArray.forEach({$0.cancel()})
        taskArray = []
    }
    
    func getData() {
        //Assigned task to some task
        someTask = Task {
             let data = await manager.getAPIData()
             self.data = data
        }
    }
    
    func getMultipleTask() {
        
        //Multiple task going on then how to cancle
        let task1 = Task {
             let data = await manager.getAPIData()
             self.data = data
        }
        taskArray.append(task1)
        
        let task2 = Task {
            let data = await manager.getAPIData()
            self.data = data
        }
        taskArray.append(task2)
        
        let task3 = Task {
            let data = await manager.getAPIData()
            self.data = data
        }
        taskArray.append(task3)
    }
    
   //We don't want to cancle task purposely and keep strong reference
    func getMultipleTask1() {
        
        Task {
             let data = await manager.getAPIData()
             self.data = data
        }
           
       //We want to keep strong reference so task detached in closure
        Task.detached { [self] in //Strong self for detached task
            let data = await manager.getAPIData()
            await MainActor.run {
                self.data = data
            }
        }
       
    }
    
}


struct StrongSelfTest: View {
    @StateObject private var vm = StrongSelfTestViewModel()
        
    var body: some View {
        Text(vm.data)
            .onAppear(){
                vm.getData()
            }
            .onDisappear() {
                //Cancel Task running once screen disappear
                vm.cancelTask() //Remove references
            }
            .task {
                //Automatically cancle task when disappear screen
            }
    }
}

#Preview {
    StrongSelfTest()
}
