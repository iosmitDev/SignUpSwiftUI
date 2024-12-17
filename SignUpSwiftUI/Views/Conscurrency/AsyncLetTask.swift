//
//  AsyncLetTask.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 22/11/24.
//

import SwiftUI

class AsyncLetImagesViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
        
    func getImages() {
        
        
    }
}




struct AsyncLetTask: View {
    
    //Create flexible VGrid colums to adjust automatically 2 items
    let gridItems = [GridItem(.flexible()),GridItem(.flexible())]
    
    //Created black images array to load in VGrid
    @State private var images: [UIImage] = [] //Create image array
    
    //Create VM object
    @StateObject var vm = AsyncLetImagesViewModel()
    
    //API URL
    let url = URL(string: "https://picsum.photos/300")!
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, content: {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Async Let Images 😎")
            .onAppear() {
               // vm.getImages()
                
                /*
               
                
                //Calling 2 api for diffrent data and pass response to another
                //Diffrent task to call fast api then cancel handling is very critical and set diffrent priority is also tedious
                Task {
                    
                    do{
                        let image = try await fetchImages()
                        self.images.append(image)
                        
                        let image1 = try await fetchImages()
                        self.images.append(image1)
                      
                    }
                    catch {
                        print(error)
                    }
                }
                
                //Calling another 1 task here to break and call fast
                Task {
                    
                    do{
                                                
                        let image2 = try await fetchImages()
                        self.images.append(image2)
                      
                    }
                    catch {
                        print(error)
                    }
                }
                
                //Calling another 2 task here to break and call fast
                Task {
                    
                    do{
                        let image3 = try await fetchImages()
                        self.images.append(image3)
                    }
                    catch {
                        print(error)
                    }
                }
                
                */
                
                /*
                Task {
                    
                    //Async store in Async
                    async let image1 = fetchImages()
                    async let image2 = fetchImages()
                    async let image3 = fetchImages()
                    async let image4 = fetchImages()
                    
                    //it will wait till all download less or fast
                    let (imag1, imag2, imag3, imag4) = await (try image1,try image2,try image3,try image4)
                    
                    //Append combines so immediate show all
                    self.images.append(contentsOf: [imag1, imag2, imag3, imag4])
                }
                */
                
                //Create Async environment
                Task {
                    async let image = fetchImages()
                    async let title = fetchTitle()
                    
                    //Perform both at same time
                    let (finalImage, finalTitle) = await (try image, title)
                    
                    self.images.append(contentsOf: [finalImage])
                    
                   //If we want to call 50 fetch then need to write 50 times??
                  //So we can use Taskgroup for multiple async function execute at once
                                        
                }
                
            }
        }
        
    }
    
    func fetchImages() async throws -> UIImage
    {
        //Make server call and get images
       // self.images.append(UIImage(systemName: "house")!)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
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
    
    func fetchTitle() async -> String {
        return "hello"
    }
}

#Preview {
    AsyncLetTask()
}
