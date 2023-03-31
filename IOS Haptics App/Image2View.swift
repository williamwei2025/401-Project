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

                        }
            }
    }
}


//struct Image2View_Previews: PreviewProvider {
//    static var previews: some View {
//        Image2View()
//    }
//}
