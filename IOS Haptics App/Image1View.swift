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


    @State private var offset = CGSize.zero
    @State private var previousDragValue: DragGesture.Value?
    @State private var velocity = Float(0)
    
    @State var engine: CHHapticEngine?
    @State var continuousPlayer: CHHapticAdvancedPatternPlayer!
    
    
    let size = 600
    let pointer = APIWrapper().generate()
    let surf = Int32(1)
    @State var sharpnessArray = [Float](repeating: 1, count: 600)
    
    
    init()
    {
        print("Creating Engine")
        createEngine()
        
//        let filepath = "/Users/willw/Documents/401-Project/IOS Haptics App/XML/Models_Book.xml"
//        let url = URL(fileURLWithPath: filepath)
//        let parentdir = url.deletingLastPathComponent()
//        FileManager.default.changeCurrentDirectoryPath(parentdir.path)
//        let relativepath = url.lastPathComponent
//        print("Relative path of file: \(relativepath)")
        
        
        APIWrapper().output(pointer, sharpnessArray:&sharpnessArray, size:Int32(size), interpSurf: surf, interpSpeed: velocity, interpForce: 1.0)
        
        
        globalQueueTest()
    
        
           
    }
    
    
    
    func globalQueueTest(){
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            self.firstthread()
        }
    }
    
    func firstthread(){
         while(true){
             playHapticTransient()
         }
    }
    
      
    
    var body: some View {
        Image("grass")
            .resizable()
            .frame(width: 400, height: 400)
            .offset(offset)
            .scaledToFit()
            .gesture(DragGesture(minimumDistance: 10).onChanged({ value in
                if let previousValue = self.previousDragValue {
                                    // calc velocity using currentValue and previousValue
                self.calcDragVelocity(previousValue: previousValue, currentValue: value)
                }
                self.previousDragValue = value
                APIWrapper().output(pointer, sharpnessArray:&sharpnessArray, size:Int32(size), interpSurf: surf, interpSpeed: velocity, interpForce: 1.0)
            }).onEnded({ value in
                velocity = Float(0)
                APIWrapper().output(pointer, sharpnessArray:&sharpnessArray, size:Int32(size), interpSurf: surf, interpSpeed: velocity, interpForce: 1.0)
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
    
    
   func playHapticTransient() {
        
        let freq = 1.0 / Double(300)
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                        value: Float(1))
        
        var events : [CHHapticEvent] = []
        
       
       for i in 0..<40 {
           let startIndex = i*15
           let endIndex = (i+1)*15 - 1
           let hapticIntensities = Array(sharpnessArray[startIndex...endIndex])
           
           for j in 0..<15 {
               let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                               value: Float(hapticIntensities[j]))
               events.append( CHHapticEvent(eventType: .hapticTransient,
                                            parameters: [intensityParameter, sharpnessParameter],
                                            relativeTime: Double(j)*freq))
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
    
   
    
    /// - Tag: CreateContinuousPattern
    func playHapticContinuous(time: TimeInterval,
                                      intensity: Float,
                                      sharpness: Float,
                                      frequency: Int,
                                      sharpnessArray: [Float]) {
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                          value: intensity)
        
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                          value: sharpness)
        
        var events : [CHHapticEvent] = []
        
        let hapticintensities = sharpnessArray
        
        var freq = 1.0 / Double(frequency)
        freq = 1
        for i in 0..<100
        {
            let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                            value: Float(hapticintensities[i]))
            events.append (CHHapticEvent(eventType: .hapticContinuous,
                                        parameters: [intensityParameter, sharpnessParameter],
                                        relativeTime: Double(i)*freq,
                                         duration: freq ) )
        }
        
        
        // Create a pattern from the haptic event.
        do {
            
            // Start the engine in case it's idle.
            try engine?.start()
            
            let pattern = try CHHapticPattern(events: events, parameters: [])
            
            continuousPlayer = try engine?.makeAdvancedPlayer(with: pattern)
            try continuousPlayer?.start(atTime: CHHapticTimeImmediate)

        } catch let error {
            print("Pattern Player Creation Error: \(error)")
        }
    }
    
    
}

