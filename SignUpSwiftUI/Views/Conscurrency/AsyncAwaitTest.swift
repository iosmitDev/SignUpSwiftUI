//
//  AsyncAwaitTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 21/11/24.
//

import SwiftUI


class asyncAwaitViewModel: ObservableObject {
    
    @Published var dataArray = [String]()
    
    func getTitle() {
        
        dataArray.append("title 1")
    }
    
    func getTitle1() {
        
        dataArray.append("title 1 \(Thread.current)")
    }
    
    func getTitle2() {
        
        //Create global queue for BG task , name is null
        DispatchQueue.global().asyncAfter(deadline: .now() + 2){
            self.dataArray.append("title 1 \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray.append("title 2")
                
                let title3 = "title3: \(Thread.current)"
                self.dataArray.append(title3)
                
            }
        }
        
    }
    //if you need to call async method then it should be await
    func addAuthor() async {
        
        let Author = "Mitesh: \(Thread.current)"
        self.dataArray.append(Author)
        
        //Throwing so use optional try to avoid do-catch
       // sleep is async function so we use await before call func
      try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        
        DispatchQueue.main.async {
            let Author1 = "Mitesh 1: \(Thread.current)"
            self.dataArray.append(Author1)
        }
        
        let Author2 = "Mitesh 2: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(Author2)
            
            let Author3 = "Mitesh 3: \(Thread.current)"
            self.dataArray.append(Author3)
        }
    }
}


struct AsyncAwaitTest: View {
    
    @StateObject var vm = asyncAwaitViewModel()
    var body: some View {
               
        List {
            ForEach(vm.dataArray, id: \.self) { value in
                Text(value)
            }
        }
//        .onAppear(){
//            
//            //vm.getTitle2()
//            
//       Task{ //create async enviornment
//            await vm.addAuthor()//async method call then await must
//           }
//        }
        .task {
            await vm.addAuthor()
            
        }
        
    }
}

#Preview {
    HomeView()
}


struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                NavigationLink("Click me 😹"){
                    DownloadImageAsync()
                }
            }

        }
    }
}
