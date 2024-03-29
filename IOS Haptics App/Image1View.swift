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

var velocity = Float(0)
let pointer = APIWrapper().generate()
let size = 600
var intensityArray = [Float](repeating: 1, count: 600)
var surf = Int32(1)
let hm = HapticsManager()
var running : Bool = false


struct Image1View: View {
    let selectedOption: Int // Add the selectedOption property
    @State private var offset = CGSize.zero
    @State private var previousDragValue: DragGesture.Value?
    

    var body: some View {
        VStack {
            Text("Selected option: \(selectedOption)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            
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
                    APIWrapper().output(pointer, sharpnessArray:&intensityArray, size:Int32(size), interpSurf: surf, interpSpeed: velocity, interpForce: 1.0)
                }).onEnded({ value in
                    velocity = Float(0)
                    APIWrapper().output(pointer, sharpnessArray:&intensityArray, size:Int32(size), interpSurf: surf, interpSpeed: velocity, interpForce: 1.0)
                }))
        }
        .onAppear {
            print("Creating Engine")
            hm.createEngine()
            surf = Int32(selectedOption)
            APIWrapper().output(pointer, sharpnessArray:&intensityArray, size:Int32(size), interpSurf: surf, interpSpeed: velocity, interpForce: 1.0)
            running = true
            globalQueueTest()
           
        }
        .onDisappear{
            hm.destroyEngine()
            running = false
        }
    }
    
    func globalQueueTest(){
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            self.firstthread()
        }
    }

    func firstthread(){
         while(running){
             let start = DispatchTime.now() // capture the current time
             hm.playHapticTransient()
             
             let end = DispatchTime.now() // capture the current time again after your code runs
             let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // calculate the difference in nanoseconds
             let timeInterval = Double(nanoTime) / 1_000_000_000 // convert to mili seconds
             print("Time taken: \(timeInterval) seconds")
             

         }
    }
    
    func calcDragVelocity(previousValue: DragGesture.Value, currentValue: DragGesture.Value) {
            let timeInterval = currentValue.time.timeIntervalSince(previousValue.time)

            let diffXInTimeInterval = Double(currentValue.translation.width - previousValue.translation.width)
            let diffYInTimeInterval = Double(currentValue.translation.height - previousValue.translation.height)

            let velocityX = diffXInTimeInterval / timeInterval
            let velocityY = diffYInTimeInterval / timeInterval

            velocity = Float( sqrt(velocityX * velocityX + velocityY * velocityY) )
    }
}



class HapticsManager {

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

    func destroyEngine(){
        engine?.stop()
        engine = nil
    }

   func playHapticTransient() {

        let freq = 1.0 / Double(300)
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                        value: 0.5)

        var events : [CHHapticEvent] = []


       for i in 0..<40 {
           
           let start = DispatchTime.now() // capture the current time
           
           let startIndex = i*15
           let endIndex = (i+1)*15 - 1
           let hapticIntensities = Array(intensityArray[startIndex...endIndex])
           //print(hapticIntensities[0])

           for j in 0..<15 {
               let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                               value: Float(hapticIntensities[j]))
               events.append( CHHapticEvent(eventType: .hapticTransient,
                                            parameters: [intensityParameter, sharpnessParameter],
                                            relativeTime: Double(j)*freq))
           }

           do {

               // Start the engine in case it's idle.
               try engine?.start()
               let pattern = try CHHapticPattern(events: events, parameters: [])

               // Create a player to play the haptic pattern.
               let player = try engine?.makeAdvancedPlayer(with: pattern)
               try player?.start(atTime: CHHapticTimeImmediate)
               
           } catch let error {
               print("Error creating a haptic transient pattern: \(error)")
           }
           
           let end = DispatchTime.now() // capture the current time again after your code runs
           let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // calculate the difference in nanoseconds
           let timeInterval = Double(nanoTime) / 1_000_000_000 // convert to seconds

           
           usleep(27 * 1000)
           
           
           let newend = DispatchTime.now() // capture the current time again after your code runs
           let newnanoTime = newend.uptimeNanoseconds - start.uptimeNanoseconds // calculate the difference in nanoseconds
           let newtimeInterval = Double(newnanoTime) / 1_000_000_000 // convert to seconds
           //print("Time taken: \(newtimeInterval) seconds")
           
       }
       
       
    }
}
