//
//  InstructionsView.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 9/24/22.



import SwiftUI

struct InstructionView: View {
    
    @State private var instructions = "These are the instructions for this app. Click on the menu button to access a list images. You can tap on any image you want for the haptics experience you are looking for."
    
    var body: some View {
        
        NavigationView{
            VStack (alignment: .center, spacing: 10){
                
                HeaderBarTitle(title: "Instructions", size: 40)
                    .offset(y:0)
                
                Text(instructions)
                    .multilineTextAlignment(.center)
                    .frame(width: 350, height: 400, alignment: .center)
                    .background(Color.yellow)
                    .cornerRadius(50)
                    .shadow(radius: 5)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .black, design: .rounded))
                
                NavigationLink(destination: MenuView()){
                    Text("Menu")
                        .frame(width: 150, height: 100, alignment: .center)
                        .background(Color.cyan)
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
