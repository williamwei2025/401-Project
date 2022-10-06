//
//  Image1View.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 10/1/22.
//

import SwiftUI

struct Image1View: View {
    var body: some View {
        Image("moo2")
                    .resizable()
                    .scaledToFit()
    }
}

struct Image1View_Previews: PreviewProvider {
    static var previews: some View {
        Image1View()
    }
}
