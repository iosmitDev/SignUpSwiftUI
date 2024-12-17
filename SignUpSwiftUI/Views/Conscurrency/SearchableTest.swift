//
//  SearchableTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 28/11/24.
//

import SwiftUI
import Combine

//get resturant name, cuisine name list manually
struct Restaurent: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let cuisine: CuisineOption
}

//We have fixed type cuisine list so we use enum
enum CuisineOption: String {
    case kathiyawadi
    case gujarati
    case punjabi
    case surti
}

//Get Restaurent data from DataManager
class RestaurentDataManager {
    
    //Add Static data that has came from API
    //It will return Restaurent array list
    func getResturentList() async throws -> [Restaurent] {
        
        [
            Restaurent(name: "Raheda", cuisine: .gujarati),
            Restaurent(name: "Bhavnagar", cuisine: .kathiyawadi),
            Restaurent(name: "Punjab", cuisine: .punjabi),
            Restaurent(name: "Surat", cuisine: .surti)
        ]
        
    }
}

@MainActor final class RestaurentViewModel: ObservableObject {
    
    /// Create Data manager object
    let manager = RestaurentDataManager()
    
    /// Create Restaurent type blank array to store list of Restaurent to publish
    @Published private(set) var restaurentArray: [Restaurent] = []
    
    //We will not modify arestaurentArray but create filter array
    @Published private(set) var filterArray: [Restaurent] = []
    
    //Here we pass wheatever we search in view
    @Published var searchText: String = ""
    
    var cancellable = Set<AnyCancellable>()
    
    //Check wheather is searching or not
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    init() {
        searchFunctionality()
    }
    
    //Add publisher here to search text continuosly
    //Add debounce 0.3 second
    //use sink subscriber to receive value from publisher
    func searchFunctionality() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                print(value)
                self?.filterRestaurent(searchText: value)
            }
            .store(in: &cancellable)
    }
    
    private func filterRestaurent(searchText: String) {
                
        let search = searchText.lowercased()
        
        guard !searchText.isEmpty else {
            filterArray = []
            return
        }
       
          filterArray = restaurentArray.filter({ restaurent in
              
              let nameSearch = restaurent.name.lowercased().contains(search)
              let cuisineSearch = restaurent.cuisine.rawValue.lowercased().contains(search)
              return nameSearch || cuisineSearch
            })
            print(filterArray.count)
       
    }
    
    func getRestaurentList() async {
        Task {
            self.restaurentArray = try await manager.getResturentList()
        }
    }
    
}

struct SearchableTest: View {
    
    @StateObject private var vm = RestaurentViewModel()
    
    var body: some View {
        
        //Create scrollview with vstack
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.isSearching ? vm.filterArray : vm.restaurentArray) { restaurent in
                   RestaurentView(restaurent: restaurent)
                }
            }
            .padding()
            .navigationTitle("Restaurent")
           // .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $vm.searchText, prompt: Text("Search Food...")) //Prompt is placeholder
            .task {
                await vm.getRestaurentList()
            }
        }
    }
}

struct RestaurentView: View {
    
    var restaurent: Restaurent
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            Text(restaurent.name)
                .font(.headline)
            Text(restaurent.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black.opacity(0.07))
        
    }
}

#Preview {
    NavigationStack {
        SearchableTest()
    }
}
