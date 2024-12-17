//
//  CheckedContinuationTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 23/11/24.
//

import SwiftUI


class APIManager {
    let url = URL(string: "https://picsum.photos/300")!
   //Old API Call
    func fetchLoyaltyData1(comepletionHandler: @escaping (_ data: Data) -> Void) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data = data {
                    
                    comepletionHandler(data)
                }
               
        }
            .resume()
    }
        
    func fetchLoyaltyData() async throws-> Data {
        //returns generic so returning withCheckedContinuation data
       return try await withCheckedThrowingContinuation { continuation in
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data = data {
                    print(data)
                    continuation.resume(returning: data)
                }
                else if let error {
                    print(error)
                    continuation.resume(throwing: error)
                }
                else {
                    continuation.resume(throwing: URLError(.badURL))
                }
                
            }
            .resume()
        }
    }
    //Create first async function
    //add withCheckedContinuation inside
    //inside call urlsessiondata task function which are not async
    func fetchLoyaltyData2() async -> Data {
       return await withCheckedContinuation { continuation in
            fetchLoyaltyData1 { data in
             continuation.resume(returning: data)
                
            }
        }
    }
}

class CheckedContinuationTestViewModel: ObservableObject {
    let manager = APIManager()
    
    @Published var image: UIImage? = nil
    
    func getAsyncDataFromSync() async {
        
        let data = await manager.fetchLoyaltyData2()
            if let image = UIImage(data: data) {
                
                await MainActor.run {
                    self.image = image
                }
            }
        
    }
}

struct CheckedContinuationTest: View {
    
    @StateObject var vm = CheckedContinuationTestViewModel()
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
            }
        }
        .task {
            await vm.getAsyncDataFromSync()
        }
    }
}

#Preview {
    CheckedContinuationTest()
}
