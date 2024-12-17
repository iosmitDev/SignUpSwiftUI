//
//  AudioPlayerView.swift
//  SignUpSwiftUI
//
//  Created by MiteshKumar Patel on 15/11/24.
//

import SwiftUI
import AVKit

struct AudioPlayerView: View {
    
    //Name of Audio file so we can use while fetching
    let audioFileName = "audioFile"
    
    //play pause value change
    @State var isPlaying = false
    
   //We need to use AVkit to play audio using AVPlayer,create OBJ
    @State var avPlayer: AVAudioPlayer?
    
    //Total time
    @State var totalTime: TimeInterval = 0.0
    
    //Remaining time
    @State var currentTime: TimeInterval = 0.0
        
    
    //Save current date state
    @State var currentDate = Date.now
    
    //Slider value
    @State var value = 0.0
       
    
    //Create timer that publish value
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Audio Sound")
                    .font(.title)
                    .fontWeight(.medium)
                                
                   
                VStack(spacing: 20) {
                   
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.largeTitle)
                        .onTapGesture {
                            isPlaying ? stopAudio() : playAudio()
                        }
                    
                    Slider(value: Binding(get: {
                        currentTime
                    }, set: { newValue in
                        seekAudio(to: newValue)
                    }), in: 0...totalTime)
                    .accentColor(.green)
                    
                    HStack {
                        Text(timeString(time: currentTime))
                                                       
                        Spacer()
                        
                        Text(timeString(time: totalTime))
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
             
            }
            .foregroundColor(.white)
        }
        .onAppear(perform: {
            setupAudio()
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            updateProgress()
        })
    }
    
    // MARK: Setup Audio
    private func setupAudio() {
        guard let audioURL = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else {return}
        
        do {
            avPlayer = try AVAudioPlayer(contentsOf: audioURL)//Load content from URL
            avPlayer?.prepareToPlay() //Prepare for play
            totalTime = avPlayer?.duration ?? 0.0 //Play time
            
        } catch  {
            print("Error loading audio \(error)")
        }
        
    }
    
    // audioFile.mp3
   private func playAudio() {
      avPlayer?.play() //We created object because to access here
      isPlaying = true
    }
    
    private func stopAudio() {
        avPlayer?.pause() //Pause audio
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = avPlayer else {return}
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        avPlayer?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time)/60
        let second = Int(time) % 60
        return String(format: "%02d:%02d", minute, second)
    }
}

#Preview {
    AudioPlayerView()
}
