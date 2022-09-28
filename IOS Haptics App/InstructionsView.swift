//
//  InstructionsView.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 9/24/22.



import SwiftUI

struct InstructionView: View {
    var body: some View {
        VStack (alignment: .center, spacing: 20){
            HeaderBarTitle(title: "Instructions", size: 20)

        }
        .padding()



    }

    struct InstructionView_Previews: PreviewProvider {
        static var previews: some View {
            InstructionView()
        }
    }
}
