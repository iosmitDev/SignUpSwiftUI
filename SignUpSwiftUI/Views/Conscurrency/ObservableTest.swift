//
//  ObservableTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 28/11/24.
//

import SwiftUI

//Observable macro is used to replace observableobject and published and stateobject to state

actor ObservableDataManager {
    
    func getObservableObjectData() -> String {
        
        return "Welcome pina"
    }
    
}
//Removed ObservableObject, Published
//use main actor at function and variable where it will be used in main thread
//We use await MainActor.run to assign value
   @Observable final class ObservableTestViewModel {
    @ObservationIgnored let manager = ObservableDataManager()
    @MainActor private(set) var title: String = "Welcome"
    
    
    func getTitleValue() async {
       
       let title = await manager.getObservableObjectData()
      
        await MainActor.run {
            self.title = title
            print(Thread.current)
        }
        
        
    }
}

struct ObservableTest: View {
    
    @State private var vm = ObservableTestViewModel()
    
    var body: some View {
        Text(vm.title)
            .task {
               await vm.getTitleValue()
            }
    }
}

#Preview {
    ObservableTest()
}
