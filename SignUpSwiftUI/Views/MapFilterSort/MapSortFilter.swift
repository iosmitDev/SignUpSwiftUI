//
//  MapSortFilter.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 02/12/24.
//

import SwiftUI

struct MapSortFilter: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                testFilterSortMap()
            }
    }
    
    func testFilterSortMap() {
        
//        let allNames = allUser.map({$0.name})
//        print(allNames)
      
//        let filterName = allUser.filter({$0.order > 4})
//        print(filterName)
        
//        var allPremiumUsers:[DataBaseUser] = allUser.filter({$0.isPremium})
//        print(allPremiumUsers)
        
//        let allPremiumUsers = allUser.filter { user in
//            if user.isPremium {
//                return true
//            }
//            return false
//        }
//        print(allPremiumUsers)
        
        let allPremiumUsers = allUser.filter { user in
            return user.isPremium
        }
        print(allPremiumUsers)
        
        //Sorting
//        let orders = allUser.sorted(by: {$0.order < $1.order})
//        print(orders)
        
        //let orders = allUser.filter({$0.order > 4})
        //print(orders)
        
        //get sorted all names from array
//        let allNames = allUser.map({$0.name}).sorted()
//                print(allNames)
        
        let allNames = allUser.filter({$0.order > 1}).map({$0.name}).sorted()
         print(allNames)
    }
}

#Preview {
    MapSortFilter()
}
struct DataBaseUser {
    let name: String
    let order: Int
    let isPremium: Bool
}

//Received all user from database which confirm above model
let allUser: [DataBaseUser] = [
    DataBaseUser(name: "mitesh", order: 1, isPremium: true),
    DataBaseUser(name: "Pino", order: 5, isPremium: false),
    DataBaseUser(name: "Hinu", order: 4, isPremium: true),
    DataBaseUser(name: "gugu", order: 100, isPremium: true)
]
