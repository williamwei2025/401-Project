//
//  HomeView.swift
//  IOS Haptics App
//
//  Created by user228516 on 9/24/22.
//

import SwiftUI
import CoreHaptics
import AVFoundation

struct HomeView: View {
    

    var body: some View {
        
        NavigationView{
            
            ZStack {
                // Background color
                Color.orange.edgesIgnoringSafeArea(.all)
                
                // Background pattern
                VStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .opacity(0.5)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .opacity(0.5)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.bottom, 20)
                
                VStack (alignment: .center, spacing: 100){
                    HeaderBarTitle(title: "Haptics", size: 40)
                        .offset(y:-100)

                    NavigationLink(destination: InstructionView()){
                        Text("Instructions")
                            .frame(width: 150, height: 100, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .black, design: .rounded))
                    }
                }
            }
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

