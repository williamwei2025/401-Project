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
    
    init()
    {
        //print("Start")
        let url = Bundle.main.resourceURL
        let path = url?.absoluteString
        //let swiftString:String = url?.absoluteString
        //let objCString:NSString = NSString(string:swiftString)
        //let x = APIWrapper().output(path, interpSurf: 1, interpSpeed: 1.0, interpForce: 1.0)
        //print(x)
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

        for output in output {
            eps.append(EventParameters(ParameterID: "HapticSharpness", ParameterValue: Float(output)))
        }
        
        var x = 0.0
        for ep in eps {
            var eventparameter = [ep]
            es.append(Events(Time: Float(x), EventType: "HapticTransient", EventParameters: eventparameter))
            x += 0.1
        }
        
        var patterns = Patterns(Event: es)
        
        var afile = AHAPFile(Version: 1, Pattern: patterns)
        
        do {
            let jsonData = try JSONEncoder().encode(afile)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
        } catch { print(error) }
        
        
        
    }
    
    func secondthread(){
        
    }
    
    @State private var offset = CGSize.zero
    @State private var previousDragValue: DragGesture.Value?    
    
    var body: some View {
        Image("moo2")
            .resizable()
            .frame(width: 100, height: 100)
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
    let Pattern:Patterns
}

struct Patterns : Codable {
    let Event: [Events]
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

