//
//  LottieAnimationView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 01/12/24.
//

import SwiftUI
import Lottie


struct name: Hashable {
    
    let title: String
    let subTitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subTitle)
    }
}

struct LottieAnimationView: View {
    
    var animtionDidFinish: (() -> Void)?
        
    var body: some View {
              
            LottieView(animation: .named("startAnimation2"))
                .configure({ lottieView in
                    lottieView.contentMode = .scaleAspectFit
                })
                .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
                .animationDidLoad { completed in
                    animtionDidFinish?()
                }
            
      
//        // Play the animation once, from the start to the end
//        LottieView(animation: .named("startAnimation2"))
//          .playing()
//          
//        // Loop the animation from the start to the end
//        LottieView(animation: .named("startAnimation2"))
//          .looping()
          
//        // Display the animation paused at the half way mark
//        LottieView(animation: .named("startAnimation2"))
//          .currentProgress(0.5)
        
        
    //https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4
    }
}

#Preview {
    LottieAnimationView()
}
