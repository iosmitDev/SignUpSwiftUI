//
//  TaskGroupTest.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 22/11/24.
//

import SwiftUI

protocol ImageDownloadDelegate {
   
    func fetchImagesWithAsyncLet() async throws -> [UIImage]
    func fetchImageWithtaskGroup() async throws -> [UIImage]
}

//Data manager confirms protocol delegate
class ImageManager: ImageDownloadDelegate {
   
    //Fetch image array with async let of below method
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        let url = URL(string: "https://picsum.photos/300")!
        
        async let image1 = fetchImages(urlString: url)
        async let image2 = fetchImages(urlString: url)
        async let image3 = fetchImages(urlString: url)
        async let image4 = fetchImages(urlString: url)
        
       let(img1, img2, img3, img4) = await (try image1, try image2, try image3, try image4)
        
        return [img1, img2, img3, img4]
    }
    
    //Fetch image array through TaskGroup
    func fetchImageWithtaskGroup() async throws -> [UIImage] {
        
        let url = URL(string: "https://picsum.photos/300")!
        
        let urlStrings = [
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300",
            "https://picsum.photos/300"
        ]
        
        //Taskgroup with throwing error or not
        // Here throwing so withThrowingTaskGroup
        //Child type or sendable type is return specific data
        //Here Uiimage.self => image type returning
        //It should be optiona if task fail then it goes ahead
      return try await withThrowingTaskGroup(of: UIImage?.self) { group in
        
        //Here we need to retun images array so create empty first
         var images: [UIImage] = []
         images.reserveCapacity(urlStrings.count)
           
        //Now add task to group, create diffrent group task for diffrent api call, manually created 4 task but we need to call for diffrent task so do in for loop
//          group.addTask {
//              try await self.fetchImages(urlString: url)
//          }
//          
//          group.addTask {
//              try await self.fetchImages(urlString: url)
//          }
//          
//          group.addTask {
//              try await self.fetchImages(urlString: url)
//          }
//          
//          group.addTask {
//              try await self.fetchImages(urlString: url)
//          }
          
          //We create Group.addTask with multiple api call so we do for in loop and call
          for urls in urlStrings {
              //If any one of task fails then it will continue not whole waste
              group.addTask {
                  try? await self.fetchImages(urlString: URL(string: urls)!)
              }
          }
          
          //Here group holds result of all task that is image
          //We will for in loop over to get result
          //We will wait for result above then it will work
          for try await image in group {
              //append one by one image to array
              
              if let image = image {
                  images.append(image)
              }
          }
          
           return images
        }
        
    }
    
    
  private func fetchImages(urlString: URL) async throws -> UIImage
    {
        do {
            let (data, _) = try await URLSession.shared.data(from: urlString)
            
            if let image = UIImage(data: data) {
                return image
            }
            else {
               throw URLError(.badServerResponse)
            }
            
        } catch  {
            throw error
        }
       
    }
}

//Actual app have ViewModel => DownloadManager class
class TaskGroupTestViewModel: ObservableObject {
    @Published var images = [UIImage]()
        
   private let ImageDownloadManager: ImageDownloadDelegate
    
    init(ImageDownloadManager: ImageDownloadDelegate = ImageManager()) {
       
        self.ImageDownloadManager = ImageDownloadManager
    }
    
    func fetchImages() async {
        //If there is optional then use if let
//     if let image = try? await ImageDownloadManager.fetchImagesWithAsyncLet()
//     {
//         self.images.append(contentsOf: image)
//     }
        
        if let image = try? await ImageDownloadManager.fetchImageWithtaskGroup() {
            self.images.append(contentsOf: image)
        }
        
        
    }
}

//Actual app have View => ViewModel
struct TaskGroupTest: View {
    
    //Create VM object
    @StateObject var vm = TaskGroupTestViewModel()
    
    //Create vertical grid array with Grid item with felxible space
    let items = [GridItem(.flexible()),GridItem(.flexible())]
            
    var body: some View {
        
        //Create navigation stack and add scrollView
                
        NavigationStack {
            ScrollView {
                    LazyVGrid(columns: items, content: {
                        ForEach(vm.images, id: \.self) {value in
                        Image(uiImage: value)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        }
                        
                    })
                
            }
            .task {
                    await vm.fetchImages()
                }
           
            .navigationTitle("TaskGroup 🌍")
        }
        
    }
}

#Preview {
    TaskGroupTest()
}
