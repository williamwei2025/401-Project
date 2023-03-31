//
//  MenuVIew.swift
//  IOS Haptics App
//
//  Created by user228516 on 9/28/22.
//

import SwiftUI

struct MenuView: View {
    @State private var selectedOption = 1

    var body: some View {
        
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)

            // Custom circle shape
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 200, height: 200)
                .offset(x: -100, y: -200)

            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 300, height: 300)
                .offset(x: 150, y: -180)

            VStack {
                // System image
                Image(systemName: "sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .foregroundColor(.blue)

                Text("Menu View")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    

                Picker("Select an option", selection: $selectedOption) {
                    ForEach(1..<11, id: \.self) { index in
                        Text("Option \(index)").tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                NavigationLink(destination: Image1View(selectedOption: selectedOption)) {
                    Text("Open Image1 View")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        
    }
}
      
        
//    var body: some View {
//
//            VStack (alignment: .center, spacing: 20){
//
//                HeaderBarTitle(title: "Menu", size: 40)
//                    .offset(y:-100)
//
//
//                NavigationLink(destination: Image1View()){
//                    Text("Image 1")
//                        .frame(width: 400, height: 100, alignment: .center)
//                        .background(Color.purple)
//                        .cornerRadius(25)
//                        .foregroundColor(Color.white)
//                        .font(.system(size: 20, weight: .black, design: .rounded))
//                }
//
//                NavigationLink(destination: Image2View()){
//                    Text("Image 2")
//                        .frame(width: 400, height: 100, alignment: .center)
//                        .background(Color.orange)
//                        .cornerRadius(25)
//                        .foregroundColor(Color.white)
//                        .font(.system(size: 20, weight: .black, design: .rounded))
//                }
//
//                NavigationLink(destination: MenuView()){
//                    Text("Image 3")
//                        .frame(width: 400, height: 100, alignment: .center)
//                        .background(Color.green)
//                        .cornerRadius(25)
//                        .foregroundColor(Color.white)
//                        .font(.system(size: 20, weight: .black, design: .rounded))
//                }
//
//            }
//    }


    
    struct MenuView_Previews: PreviewProvider {
        static var previews: some View {
            MenuView()
        }	
    }
