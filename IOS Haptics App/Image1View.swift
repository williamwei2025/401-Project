//
//  Image1View.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 10/1/22.
//

import SwiftUI
import UIKit
import CoreHaptics


struct Image1View: View {
    
    @State private var offset = CGSize.zero
    @State private var previousDragValue: DragGesture.Value?
    
    @State private var currentVelocity: Double?
    
    func calcDragVelocity(previousValue: DragGesture.Value, currentValue: DragGesture.Value) -> (Double)? {
            let timeInterval = currentValue.time.timeIntervalSince(previousValue.time)

            let diffXInTimeInterval = Double(currentValue.translation.width - previousValue.translation.width)
            let diffYInTimeInterval = Double(currentValue.translation.height - previousValue.translation.height)

            let velocityX = diffXInTimeInterval / timeInterval
            let velocityY = diffYInTimeInterval / timeInterval
        
            return sqrt(velocityX * velocityX + velocityY * velocityY)
        }
    
    func thread(previousValue: DragGesture.Value, currentValue: DragGesture.Value){
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            while (true) {
                currentVelocity = self.calcDragVelocity(previousValue: previousValue, currentValue: currentValue)
            }
        }
    }
    
    func secondthread(){
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            while (true) {
                print(currentVelocity)
            }
        }
    }
    
    var body: some View {
        Image("moo2")
            .resizable()
            .frame(width: 100, height: 100)
            .offset(offset)
            .scaledToFit()
            .gesture(DragGesture(minimumDistance: 10).onChanged({ value in
                if let previousValue = self.previousDragValue {
                    // calc velocity using currentValue and previousValue
                    thread(previousValue: previousValue, currentValue: value)
                    secondthread()
                }
                // save previous value
                self.previousDragValue = value
                }))
    }
    /*
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in  HapticManager.instance.impact(style: .medium) }
            .onEnded { _ in print("drag detected: medium haptic output") }
    }
                
    var body: some View {
        VStack(spacing: 10){
            
            	
            Image("moo2")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            
                            HapticManager.instance.play();
                            //HapticManager.instance.impact(style: .light)
                            	//print("tap detected: light haptic output")
                        }
                        .gesture(drag)
                        .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10) {
                            HapticManager.instance.impact(style: .medium)
                            print("tap and hold detected: heavy haptic output")
                        }
            
                        
                            
            }

    }
     */
}
	
struct Image1View_Previews: PreviewProvider {
    static var previews: some View {
        Image1View()
    }
}

class HapticManager {

    static let instance = HapticManager()
    
   

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    func play(){
        print("begin")
        var engine: CHHapticEngine
        guard let path = Bundle.main.path(forResource: "Test.ahap", ofType: "ahap") else {
            print("not found")
            return
        }        //engine = try CHHapticEngine()
        // Create and configure a haptic engine.
        do {
            engine = try CHHapticEngine()
            try engine.start()
            try engine.playPattern(from: URL(fileURLWithPath: path))
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
        print("end")
        
       
    }
    
}
        
