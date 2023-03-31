//
//  InstructionsView.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 9/24/22.



import SwiftUI

struct InstructionView: View {
    
    @State private var instructions = "Click on the menu button to access a list textures. Drag or tap the image to experience dynamic haptics."
    
    var body: some View {
        ZStack {
            // Background color
            Color.green.edgesIgnoringSafeArea(.all)
            
            // Background pattern
            VStack {
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .opacity(0.5)
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 20)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .opacity(0.5)
                }
                .padding(.trailing, 20)
            }
            .padding(.bottom, 20)
            VStack (alignment: .center, spacing: 10){
                
                HeaderBarTitle(title: "Instructions", size: 40)
                    .offset(y:0)
                
                Text(instructions)
                    .multilineTextAlignment(.center)
                    .frame(width: 350, height: 300, alignment: .center)
                    .background(Color.yellow)
                    .cornerRadius(50)
                    .shadow(radius: 5)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .black, design: .rounded))
                
                NavigationLink(destination: MenuView()){
                    Text("Menu")
                        .frame(width: 150, height: 100, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(25)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                }
            }
        }
        
    


    }

    struct InstructionView_Previews: PreviewProvider {
        static var previews: some View {
            InstructionView()
        }
    }
}
