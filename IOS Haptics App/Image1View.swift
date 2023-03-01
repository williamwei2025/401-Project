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
    @State private var velocity = Float(0)
    
    let pointer = APIWrapper().generate()
   
    
    init()
    {
        print("Start")

    
        
        APIWrapper().output(pointer, interpSurf: 1, interpSpeed: 1.0, interpForce: 1.0)
    
                
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
        
        let output = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
      
        
    }
    
    func secondthread(){
        
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




