//
//  ForInLoops.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 02/12/24.
//

import SwiftUI


struct ForInLoops: View {
    let vm = TestFunction()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear() {
                vm.testForInLoops()
            }
    }
    
}

class TestFunction: ObservableObject {
    
   @Published var vegesArray = ["Cucumber","Carrot","onion","potato","capsicum"]
    
   @Published var repeatedValueArray: [String] = []
    
    func testForInLoops() {
        
//        for item in vegesArray {
//            if item.lowercased().hasSuffix("n") {
//                repeatedValueArray.append(item)
//            }
//        }
//        print(repeatedValueArray)
        
        for (index, vegetable) in vegesArray.enumerated() {
            
            if index == 1 {
                break
            }
            
            print(index, vegetable)
           
        }
    }
}

#Preview {
    ForInLoops()
}
