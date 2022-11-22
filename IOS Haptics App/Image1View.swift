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
