//
//  MenuVIew.swift
//  IOS Haptics App
//
//  Created by user228516 on 9/28/22.
//

import SwiftUI

struct MenuView: View{
    
    
    var body: some View {
        
        NavigationView{
            VStack (alignment: .center, spacing: 20){
                
                HeaderBarTitle(title: "Menu", size: 40)
                    .offset(y:-100)
                
                
                NavigationLink(destination: Image1View()){
                    Text("Image 1")
                        .frame(width: 400, height: 100, alignment: .center)
                        .background(Color.purple)
                        .cornerRadius(25)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                }
                
                NavigationLink(destination: MenuView()){
                    Text("Image 2")
                        .frame(width: 400, height: 100, alignment: .center)
                        .background(Color.orange)
                        .cornerRadius(25)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                }
                
                NavigationLink(destination: MenuView()){
                    Text("Image 3")
                        .frame(width: 400, height: 100, alignment: .center)
                        .background(Color.green)
                        .cornerRadius(25)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                }            }
        }
        
    


    }
    
    struct MenuView_Previews: PreviewProvider {
        static var previews: some View {
            MenuView()
        }
    }
}
