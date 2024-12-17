//
//  BackgroundThreadTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 03/12/24.
//

import SwiftUI


final class DownloadManager {
    
    func downloadData() -> [String] {
        
        var tempArray: [String] = []
        for i in 0..<100{
            tempArray.append("\(i)")
        }
        return tempArray
    }
}

final class BackgroundViewModel: ObservableObject {
    
    let manager = DownloadManager()
    
    @Published var dataArray: [String] = ["No Data Available"]
       
    var isDataAvailale: Bool {
        !dataArray.isEmpty
    }
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let downloadData = self.manager.downloadData()
            print(Thread.isMainThread)
            print(Thread.current)
            DispatchQueue.main.async {
                self.dataArray = downloadData
                print(Thread.isMainThread)
                print(Thread.current)
            }
        }
    }
}

struct BackgroundThreadTest: View {
    
    @StateObject private var vm = BackgroundViewModel()
        
    var body: some View {
        ScrollView {
            //Created VStack with 2 text
            VStack(spacing: 20) {
                
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .onTapGesture {
                        vm.fetchData()
                        print("tapped")
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(vm.isDataAvailale ? item : "No Data Available")
                        .font(.headline)
                        .foregroundStyle(.red)
                }
                
            }
        }
            
    }
}

#Preview {
    BackgroundThreadTest()
}
