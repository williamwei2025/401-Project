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

    @State var param = Parameters()
    @State var engine1 = HapticEngine();
    @State var playingFile : Data!
    
    init()
    {
        print("Start")
        
//        guard let path = Bundle.main.path(forResource: "XML/Models_Binder", ofType: "ahap") else {
//            print("not found")
//            return
//        }

        //print(path)
    

        //let start = CFAbsoluteTimeGetCurrent()
        
    
        APIWrapper().output("test", interpSurf: 1, interpSpeed: 1.0, interpForce: 1.0)
        
//            let diff = CFAbsoluteTimeGetCurrent() - start
//            print("Took \(diff) seconds")

                

        engine1.createEngine()
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
        var eps: [EventParameters] = []
        var es : [Events] = []
        var bridges : [Bridge] = []

        for output in output {
            eps.append(EventParameters(ParameterID: "HapticIntensity", ParameterValue: Float(output)))
        }
        
        var x = 0.0
        for ep in eps {
            var eventparameter = [ep]
            var b = Bridge(Event: Events(Time: Float(x), EventType: "HapticTransient", EventParameters: eventparameter))
            //es.append(Events(Time: Float(x), EventType: "HapticTransient", EventParameters: eventparameter))
            bridges.append(b)
            x += 0.1
        }
        

        
        var afile = AHAPFile(Version: 1, Pattern: bridges)
        
        print("finished generating")
        
        do {
            let jsonData = try JSONEncoder().encode(afile)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            
            playingFile = jsonString.data(using: .utf8)
            self.engine1.playHapticsData(named: playingFile)
            
            print("success")
        } catch { print(error) }
        
    }
    
    func secondthread(){
        
    }
    
    @State private var offset = CGSize.zero
    @State private var previousDragValue: DragGesture.Value?    
    
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
                self.param.velocity = Float(0)
                self.param.force = Float(0)
            }))
    }
    
    func calcDragVelocity(previousValue: DragGesture.Value, currentValue: DragGesture.Value) {
            let timeInterval = currentValue.time.timeIntervalSince(previousValue.time)

            let diffXInTimeInterval = Double(currentValue.translation.width - previousValue.translation.width)
            let diffYInTimeInterval = Double(currentValue.translation.height - previousValue.translation.height)

            let velocityX = diffXInTimeInterval / timeInterval
            let velocityY = diffYInTimeInterval / timeInterval
        
            self.param.velocity = Float( sqrt(velocityX * velocityX + velocityY * velocityY) )
            self.param.force = Float(1)
        print(self.param.velocity, self.param.force)
    }
}

class Parameters{
    
    var velocity : Float?
    var force : Float
    let queue = Queue<Data>()
    
    public init()
    {
        velocity = 0.0
        force = 0.0
    }
    
}

struct Queue<T> {
  private var elements: [T] = []

  mutating func enqueue(_ value: T) {
    elements.append(value)
  }

  mutating func dequeue() -> T? {
    guard !elements.isEmpty else {
      return nil
    }
    return elements.removeFirst()
  }

  var head: T? {
    return elements.first
  }

  var tail: T? {
    return elements.last
  }
}



struct AHAPFile : Codable {
    let Version:Int
    let Pattern:[Bridge]
}

struct Bridge: Codable {
    let Event: Events
}

struct Events: Codable {
    let Time: Float
    let EventType: String
    let EventParameters: [EventParameters]
}

struct EventParameters : Codable{
    let ParameterID:String
    let ParameterValue:Float
}

