//
//  DownloadImageAsync.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 20/11/24.
//

import SwiftUI
import Combine

//We have image download manager
class DownloadImageAsyncManager {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    var callback2: ((String) -> Void)?
    
    func fetchImages() -> String {
        
        return "hello"
    }
    //Asyncronous with completion handler
    func downloadImageWithEscaping(completionHandler: @escaping (_ image: UIImage?,_ error: Error?) -> Void) {
        //Download image then use URLSession and completion handler , we will not download data we will get image url details
        
        URLSession.shared.dataTask(with: url) { data, response, error in
         //Block of code called when data comes backs from the server
            
            guard
                let data, let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode <= 300 else {
                
                completionHandler(nil, error)
                return
            }
            //Extract image from data so uiimage(data: data)
            guard let image = UIImage(data: data) else {return}
            
            //Sendback image to callback function with completion handler
            completionHandler(image, nil)
        }
        .resume() //Again it resume callback once response received
        
    }
    
    //Asyncronous with combine
    func downloadWithPublisher() -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                return data
            }
            .mapError({$0}) //map error itself error
            .eraseToAnyPublisher() //Set trymap and erasetoanypublisher

    }
    
    
    //Asyncronous with async/await
    func downloadWithAsyncAwait() async throws -> UIImage? {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
    
    func callBack(completionHandler: @escaping (String, Error)  -> Void) {
        
      //  callback2?("hello")
        
        completionHandler("hello", URLError(.badURL))
    }
    func response() {
        callBack() { value, error in
            print(value, error.localizedDescription)
        }
//        callBack1 { value in
//            print(value)
//        }
    }
    //Function that returns Void or ()
    //We know it will become open close braces
    //We want to send back data then we can pass inside ()
    func callBack1(completion: (String) -> ()) {
        self.callback2 = { value in
            print("test", value)
        }
    }
}


//Download image
class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    var cancellable = Set<AnyCancellable>()
    
    let manager: DownloadImageAsyncManager
    
    init(manager: DownloadImageAsyncManager = DownloadImageAsyncManager()) {
        self.manager = manager
    }
    
  
    func fetchImage() async {
        //Here we can write all swift code , it's not UI
        //This is async code and we are using sewlf reference here
        //avoid memory leak use weak self
//        manager.downloadImageWithEscaping { [weak self] image, error in
//            
//            DispatchQueue.main.async{
//                self?.image = image //Stromng reference so use weak self
//            }
//        }
        
        //Download with combine publisher
//        manager.downloadWithPublisher()
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finisheed")
//                case .failure(_):
//                    print("failure")
//                }
//            } receiveValue: { [weak self] data in
//                
//                self?.image = UIImage(data: data)
//                
//            }
//            .store(in: &cancellable)
        
        //Download with async await , fast and elegent
        
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        //async await downalod
        
        let image = try? await manager.downloadWithAsyncAwait()
        await MainActor.run {
            
            self.image = image
        }
             
    }
}


//Created file for download image asynchronosly
struct DownloadImageAsync: View {
    
    //Create object of Vm and get image
    @StateObject private var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        VStack {
            
            //Optional so we used if let here
            //All UI operation here
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
            }
           
        }
        
        
//        .onAppear() {
//            //When view appears, we call viewmodel method
//            
//            Task(priority: .userInitiated) {
//                
//                print(Thread.current)
//                print(Thread.threadPriority())
//                await vm.fetchImage()
//                
//            }
//           //let image = DownloadImageAsyncManager()
//           // image.response()
//           
//        }
        .task {
            await vm.fetchImage()
        }
    }
}

#Preview {
    DownloadImageAsync()
}
