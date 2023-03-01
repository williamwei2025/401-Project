//
//  Image1View.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 10/1/22.
//

import SwiftUI
import UIKit
import CoreHaptics
import AVFoundation

struct Image1View: View {

    let size = 600
    @State private var offset = CGSize.zero
    @State private var previousDragValue: DragGesture.Value?
    @State private var velocity = Float(0)
    @State private var hm = HapticsManager()
    
    let pointer = APIWrapper().generate()
    var sharpnessArray = [Float](repeating: 0, count: 600)
    
    init()
    {
        print("Start!")
        

        print("Creating Engine")
        hm.createEngine()
        print("Finished Creating Engine")
        
        
        
        APIWrapper().output(pointer, sharpnessArray:&sharpnessArray, size:Int32(size), interpSurf: 1, interpSpeed: 1.0, interpForce: 1.0)
    
        
        print("Array")
        print(sharpnessArray[20])
                
        globalQueueTest()
       
    }
    
    func globalQueueTest(){
        let globalQueue = DispatchQueue.global()
        
        globalQueue.async {
            self.firstthread()
        }
        globalQueue.async {
            self.secondthread()
        }
    }
    
    func firstthread(){
        
    }
    
    func secondthread(){
        
    }
    
      
    
    var body: some View {
        Image("grass")
            .resizable()
            .frame(width: 400, height: 400)
            .offset(offset)
            .scaledToFit()
            .onTapGesture {
                print(sharpnessArray)
//                hm.playHapticTransient(time: 0, intensity: 1, sharpness: 1, frequency: 300, sharpnessArray: sharpnessArray)
            }
            .gesture(DragGesture(minimumDistance: 10).onChanged({ value in
                if let previousValue = self.previousDragValue {
                                    // calc velocity using currentValue and previousValue
                self.calcDragVelocity(previousValue: previousValue, currentValue: value)
                }
                self.previousDragValue = value
            }).onEnded({ value in
                velocity = Float(0)
            }))
               
    }
    
    func calcDragVelocity(previousValue: DragGesture.Value, currentValue: DragGesture.Value) {
            let timeInterval = currentValue.time.timeIntervalSince(previousValue.time)

            let diffXInTimeInterval = Double(currentValue.translation.width - previousValue.translation.width)
            let diffYInTimeInterval = Double(currentValue.translation.height - previousValue.translation.height)

            let velocityX = diffXInTimeInterval / timeInterval
            let velocityY = diffYInTimeInterval / timeInterval
        
            velocity = Float( sqrt(velocityX * velocityX + velocityY * velocityY) )
            print(velocity)
    }
}


class HapticsManager {
 
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine?
    
    
    /// - Tag: CreateEngine
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
        
        print("ENGINE STARTED")
    }
    
    /// - Tag: PlayAHAP
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
    
   func playHapticTransient(time: TimeInterval,
                                     intensity: Float,
                                     sharpness: Float,
                                     frequency: Int,
                                     sharpnessArray: [Float]) {
        
        
        // Create an event (static) parameter to represent the haptic's intensity.
        
        
        // Create an event (static) parameter to represent the haptic's sharpness.
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                        value: sharpness)
        
        
        var events : [CHHapticEvent] = []
        
        let hapticintensities = sharpnessArray
        
        var freq = 1.0 / Double(frequency)
        for i in 0..<frequency
        {
            let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                            value: Float(hapticintensities[i]))
            events.append( CHHapticEvent(eventType: .hapticTransient,
                                         parameters: [intensityParameter, sharpnessParameter],
                                         relativeTime: Double(i)*freq))
        }
        
        
        // Create a pattern from the haptic event.
        do {
            
            // Start the engine in case it's idle.
            try engine?.start()
            
            let pattern = try CHHapticPattern(events: events, parameters: [])
            
            // Create a player to play the haptic pattern.
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate) // Play now.
        } catch let error {
            print("Error creating a haptic transient pattern: \(error)")
        }
    }
    
}
