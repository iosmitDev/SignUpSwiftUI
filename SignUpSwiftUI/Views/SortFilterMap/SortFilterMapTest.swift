//
//  SortFilterMapTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 06/12/24.
//

import SwiftUI

//Getting API of user data or UserDatabase data
//Created struct to handle data
struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class SortFilterMapViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    
    //Convert usermodel data array name to array of string
    @Published var mappedArray: [String] = []
    
    //It is called when class initialized
    init() {
        getData()
        updateFilteredData()
    }
        
    func getData() {
        
        let user1 = UserModel(name: nil, points: 10, isVerified: true)
        let user2 = UserModel(name: "mit", points: 29, isVerified: true)
        let user3 = UserModel(name: "hinu", points: 27, isVerified: false)
        let user4 = UserModel(name: nil, points: 39, isVerified: true)
        
        //We want to append the sequence
        dataArray.append(contentsOf: [user1, user2, user3, user4])
        
    }
    
    func updateFilteredData() {
        
        //sort
        /*
//        //Sorted array by highest points on top
//        let sortedArray = dataArray.sorted { userModel1, userModel2 in
//           return userModel1.points > userModel2.points
//        }
        
        //Sorted array by highest points on top
        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
       // print(filteredArray)
        */
        
        //Filter
        /*
       // filteredArray = dataArray.filter({$0.points > 30 })
        //filteredArray = dataArray.filter({$0.name.contains("p")})
        //filteredArray = dataArray.filter({!$0.isVerified})
        */
        
        //map
        /*
        mappedArray = dataArray.map({$0.name})
        */
        
        //Compact map, it will remove optional value from array
        /*
        mappedArray = dataArray.compactMap({$0.name})
    */
        
        //Combine all in 1
        mappedArray = dataArray.sorted(by: {$0.points > $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})
        
         }
}
struct SortFilterMapTest: View {
    
    //Init method called of viewmodel
    @StateObject private var vm = SortFilterMapViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { value in
                    Text(value).font(.headline)
                }
//                ForEach(vm.filteredArray) { item in
//                    VStack(alignment: .leading) {
//                        Text(item.name)
//                            .font(.headline)
//                            .onTapGesture {
//                               // vm.updateFilteredData()
//                            }
//                        HStack {
//                            Text("Points: \(item.points)")
//                            Spacer()
//                            
//                            if item.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    
//                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.cornerRadius(10))
                .padding(.horizontal,8)
            }
            
        }
    }
}

#Preview {
    SortFilterMapTest()
}
