//
//  HeaderBarTitle.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 9/24/22.
//

import SwiftUI

struct HeaderBarTitle: View {
    let title: String
    let size: CGFloat
    
    var body: some View {
        Group {
            Text(title)
                .font(.system(size: size, weight: .black, design: .rounded))
                .foregroundColor(.white)
                .fontWeight(.black)
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 16)
                .accessibility(identifier: title)
                .shadow(radius: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .center)
        .background(Color.red)
        .offset(y: 0)
    }
}

struct HeaderBarTitle_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBarTitle(title: "MENU", size: 60)
    }
}

