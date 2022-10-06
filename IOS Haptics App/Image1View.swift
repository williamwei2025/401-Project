//
//  Image1View.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 10/1/22.
//

import SwiftUI

struct Image1View: View {
    var body: some View {
        VStack(spacing: 10){
            Button("soft") {HapticManager.instance.impact(style: .soft)}
            Image("moo2")
                        .resizable()
                        .scaledToFit()
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
}
