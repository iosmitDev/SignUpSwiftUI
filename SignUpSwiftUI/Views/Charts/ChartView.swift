//
//  ChartView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 17/12/24.
//

import SwiftUI
import Charts
import Combine
 
/*
 
 //Commit messages for Git

 New feature :
 [Feature] Description of the feature

 Bug in Production :
 [Patch] Description of the patch

 Bug Not in Production But In my App :
 [Bug] Description of the bug

 Release Comments on Production :
 [Release] Description of the release

 Mundane Tasks :
 [Clean] description of changes
 
 */
//Stash changes later needed

struct ChartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Chart(MockData) { item in
                    SectorMark(angle: .value("Label", item), innerRadius: .ratio(0.5), angularInset: 1)
                        .foregroundStyle(item.color)
                        .annotation(position: .overlay) {
                            Text("$ \(item.primitivePlottable.description)")
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                       
                }
                .chartLegend(.visible)
                .frame(width: 350, height: 350)
                Rectangle()
                    .overlay {
                        Color.red
                        Text("Welcome")
                            .foregroundStyle(.white)
                    }
                    .cornerRadius(20)
            }
            .padding()
            .navigationTitle("Pie Charts")
            Spacer()
        }
        
    }
}

struct ContentView1: View {
    @StateObject private var viewModel = ContactsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(!viewModel.searchText.isEmpty ? viewModel.tempResult : viewModel.searchResults) { contact in
                    NavigationLink {
                        ContactsView(content: contact)
                    } label: {
                        Text(contact.name)
                    }
                }
            }
            .onDisappear() {
                viewModel.searchText = ""
                print("onDisappear called")
            }
            .onAppear(){
                viewModel.searchText = ""
                print("onAppear called")
            }
            .navigationTitle("Contacts")
            .searchable(text: $viewModel.searchText)
            .overlay {
                if !viewModel.searchText.isEmpty {
                   // ContentUnavailableView.search
                    
                  //  ContentUnavailableView
                   //     .search(text: viewModel.searchText)
                    
//                    ContentUnavailableView {
//                        Label("Notification", systemImage: "bell")
//                    } description: {
//                        Text("Notification available here")
//                    } actions: {
//                        Button(action: {
//                            
//                        }, label: {
//                            Text("Refresh")
//                        })
//                    }
                }
                                   
            }
            
        }
    }
}

class ContactsViewModel: ObservableObject {
  @Published var searchResults: [ContactData] = []
  @Published var tempResult: [ContactData] = []
  @Published var searchText: String = ""
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getContactData()
        searchResult()
        
//        $searchText
//            .debounce(for: 0.3, scheduler: DispatchQueue.main)
//            .sink { value in
//                print(value)
//                self.searchData(item: value)
//            }
//            .store(in: &cancellable)
    }
    func searchResult(){
        
            $searchText
                .dropFirst()
                .subscribe(on: DispatchQueue.main)
                .sink { value in
                    self.searchData(item: value)
                }
            .store(in: &cancellable)
        
    }
    func getContactData() {
        let contectDetails = [ContactData(name: "Hello"), ContactData(name: "Pino"), ContactData(name: "Plo")]
        searchResults = contectDetails
    }
    
    func searchData(item: String){
        
        self.tempResult = []
//        _ = self.searchResults.map { contact in
//            if contact.name.contains(item) {
//                self.tempResult.append(contact)
//            }
//        }
        
        tempResult = searchResults.filter({ ContactData in
            let name = ContactData.name.contains(item)
            return name
        })
        
        print(tempResult)
       // dump(tempResult)
    }
}

struct ContactsView: View {
    
    var content: ContactData
    var body: some View {
        Text(content.id)
    }
}

struct ContactData: Identifiable {
    let id = UUID().uuidString
    let name: String
    
}

#Preview {
    ChartView()
}
