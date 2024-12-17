//
//  SDWebImageDemo.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 30/11/24.
//

import SwiftUI
import SDWebImageSwiftUI //Import SDWebImageSwiftUI

//Setup image type
enum ImageType{
    case normal
    case animated
}

//Wrapper for Imageloader for common
//If we want to replace to any library
struct ImageLoader: View {
    
    let imageURL: String
    var mode: ContentMode = .fill
    let imageType: ImageType
    
    var body: some View {
        
        //Here we can call another method to replace kingfisher
        //If true then sdwebimage else kingfisher
        SDWebImageLoader(imageURL: imageURL, mode: mode, imageType: imageType)
    }
}


//In real app
fileprivate struct SDWebImageLoader: View {
    
    let imageURL: String
    var mode: ContentMode = .fill
    let imageType: ImageType
    
    var body: some View {
        
        //Pass webimage with url and then on success perform opn
        //make placeholder
        
        if imageType == .animated {
            
            //Gif image with sdwebimage
            //AnimatedImage with url and placeholder image
            AnimatedImage(url: URL(string: imageURL), placeholderImage: PlatformImage(systemName: "photo") )
                .onFailure { error in
                    print(error.localizedDescription)
                }
                .onSuccess { _, _, _ in
                    
                }
        }
        else {
            WebImage(url: URL(string: imageURL))
                .resizable()
                .onSuccess(perform: { _,_,_ in
                    
                })
                .indicator(.activity(style: .circular))
                .scaledToFit()
                .aspectRatio(contentMode: mode)
        }
    }
}

//https://picsum.photos/200/300
struct SDWebImageDemo: View {
    var body: some View {
        
        VStack(spacing: 20) {
            
            ImageLoader(imageURL: "https://picsum.photos/200/300", mode: .fit, imageType: ImageType.normal)
                .frame(width: 200, height: 200)
            
            
            //                ImageLoader(imageURL: "https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif", mode: .fit, imageType: ImageType.animated)
            //                .frame(width: 200, height: 200)
        }
        
    }
}

final class ImagePrefetcher {
    
    private static let instance = ImagePrefetcher()
    private init() {}
    
    let prefetcherImage =  SDWebImagePrefetcher()
    
    func startPrefetching(urlString: [URL]) {
        prefetcherImage.prefetchURLs(urlString)
    }
    
    func stopPrefetching() {
        prefetcherImage.cancelPrefetching()
    }
}

#Preview {
    SDWebImageDemo()
}
