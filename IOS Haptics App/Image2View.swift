//
//  Image2View.swift
//  IOS Haptics App
//
//  Created by user228516 on 10/12/22.
//
	

import SwiftUI
import UIKit
import CoreHaptics
import AVFoundation


struct Image2View: View {
    

    
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in  //HapticManager.instance.impact(style: .light)
                
            }
            .onEnded { _ in print("picture finished dragging") }
    }
                
    var body: some View {
        VStack(spacing: 10){
            
                
            Image("grass")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                                print("picture tapped, haptic output")
                        }
                        .gesture(drag)
                        .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) {
                            //HapticManager.instance.impact(style: .medium)
                            //print("picture tapped and held")
                        }
            }
    }
}

class HapticEngine {


    var engine: CHHapticEngine?
    

    func createEngine() {
        // Create and configure a haptic engine.
        do {
            // Associate the haptic engine with the default audio session
            // to ensure the correct behavior when playing audio-based haptics.
            let audioSession = AVAudioSession.sharedInstance()
            engine = try CHHapticEngine(audioSession: audioSession)
        } catch let error {
            print("Engine Creation Error: \(error)")
        }
        
        guard let engine = engine else {
            print("Failed to create engine!")
            return
        }
        
        
        // The stopped handler alerts you of engine stoppage due to external causes.
        engine.stoppedHandler = { reason in
            print("The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt:
                print("Audio session interrupt")
            case .applicationSuspended:
                print("Application suspended")
            case .idleTimeout:
                print("Idle timeout")
            case .systemError:
                print("System error")
            case .notifyWhenFinished:
                print("Playback finished")
            case .gameControllerDisconnect:
                print("Controller disconnected.")
            case .engineDestroyed:
                print("Engine destroyed.")
            @unknown default:
                print("Unknown error")
            }
        }
 
        // The reset handler provides an opportunity for your app to restart the engine in case of failure.
        engine.resetHandler = {
            // Try restarting the engine.
            print("The engine reset --> Restarting now!")
            do {
                try self.engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }
    }
    

    func playHapticsFile(named filename: String) {


        // Express the path to the AHAP file before attempting to load it.
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {
            return
        }

        
        do {
            // Start the engine in case it's idle.
            try engine?.start()

            // Tell the engine to play a pattern.
            try engine?.playPattern(from: URL(fileURLWithPath: path))

        } catch { // Engine startup errors
            print("An error occured playing \(filename): \(error).")
        }

    }
    
    
    func playHapticsData(named data: Data) {


        // Express the path to the AHAP file before attempting to load it.
        do {
            // Start the engine in case it's idle.
            try engine?.start()

            // Tell the engine to play a pattern.
            try engine?.playPattern(from: data)

        } catch { // Engine startup errors
            print("An error occured playing the data")
        }

    }
}




//struct Image2View_Previews: PreviewProvider {
//    static var previews: some View {
//        Image2View()
//    }
//}
