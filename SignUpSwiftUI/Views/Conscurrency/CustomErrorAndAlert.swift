//
//  CustomErrorAndAlert.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 19/11/24.
//

import SwiftUI

//if let
//do-catch
//try
//throws
//Switch

//Fetch data from another class
class DoTryCatchThrowsDataManager {
    
    let isActive: Bool = true //Static
    
    //Response then send result or send error
    func getTitle() -> (title: String?, error: Error?) {
        //If we receive isActive true then return or return error
        if isActive {
            return ("Welcome to SwiftUI", nil) 
        }
        else {
            return (nil, URLError(.badURL))
        }
    }
    
    //result we can pass Any value in success and error
    func getTitle2() -> Result<String, Error> {
        
        if isActive {
            
            return .success("welcome")
           
        }
        else {
            return .failure(URLError(.badServerResponse))
        }
        
        
    }
    
    //throws => can throw error to throws
    //If success then result string in return
    // if error then we can throws the error
    func getTitle3() throws -> String {
        
        if isActive {
            return "Welcome to SwiftUI"
        }
        else {
            throw URLError(.networkConnectionLost)
        }
    }
    
    func getTitle4() throws -> String {
        
        if isActive {
            return "Final"
        }
        else {
            throw URLError(.networkConnectionLost)
        }
    }
    
}

//Create class that confirms observableObject
//get data from Data Manager in real apps
class DoTryCatchThrowsViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    
    //Create reference of datamanager to use
    
    let manager: DoTryCatchThrowsDataManager
    
    init(manager: DoTryCatchThrowsDataManager = DoTryCatchThrowsDataManager()) {
        self.manager = manager
    }
//    init() {
//        text = "hello"
//    }
    
    func fecthData(){
         
        //option +command + leftarrow , ALT + Window + leftarrow
        /*
        let result = manager.getTitle() //response in tuple
        
        // Check for value and check for errors
        if let title = result.title {
            self.text = title
        }
        else if let error = result.error {
            self.text = error.localizedDescription
        }
         */
        /*
        let result = manager.getTitle2()
        //It gives success or failure in case
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
        */
        
        //This function can throw error so we need to use try
        //we need to handle error thrown then we use do-catch
        // Catch will be used for error handling
        //if any call failed or thrown error exit form here
        // Next step will not execute and exit from there
        do {
            //We can use try? if we don't crae about throwing error
            //we don't need do-case and we use if let with optional
            //We don't handle error, do nothing if error then
            let title = try manager.getTitle3()
            self.text = title
            
            //We can do multiple call here inside do
            let title1 = try manager.getTitle4()
            self.text = title1
            
        } catch let error {
            print("error \(error.localizedDescription)")
            self.text = error.localizedDescription
        }
        
    }
}

//get data from VM
struct CustomErrorAndAlert: View {
    
   //Initialize in View, getting changes from there in StateObject
    @StateObject private var viewModel = DoTryCatchThrowsViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(
                .red.opacity(0.4)
            )
            .onTapGesture {
                viewModel.fecthData()
            }
        
    }
}

#Preview {
    CustomErrorAndAlert()
}
