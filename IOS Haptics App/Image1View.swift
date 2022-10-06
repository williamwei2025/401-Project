//
//  Image1View.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 10/1/22.
//

import SwiftUI
import UIKit



class ViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView! {
            didSet {
                imageView.isUserInteractionEnabled = true
                imageView.image = UIImage(named: "moo2")
                imageView.frame.size.width = 200
                imageView.frame.size.height = 200
                imageView.center = self.view.center
                self.view = view
                
            }
        }

    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        print("did tap view", sender)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize Tap Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))

        // Configure Tap Gesture Recognizer
        tapGestureRecognizer.numberOfTapsRequired = 2
        guard tapGestureRecognizer.view != nil else { return }
        // Add Tap Gesture Recognizer
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

//struct Image1View: View {
//    var body: some View {
//        VStack(spacing: 10){
//            Button("soft") {HapticManager.instance.impact(style: .soft)}
//            Image("moo2")
//                        .resizable()
//                        .scaledToFit()
//        }
//
//    }
//}
//
//struct Image1View_Previews: PreviewProvider {
//    static var previews: some View {
//        Image1View()
//    }
//}

//class HapticManager {
//
//    static let instance = HapticManager()
//
//    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(type)
//    }
//
//    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
//        let generator = UIImpactFeedbackGenerator(style: style)
//        generator.impactOccurred()
//    }
//}
