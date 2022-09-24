    //
    //  ContentView.swift
    //  IOS Haptics App
    //
    //  Created by user228516 on 9/24/22.
    //

    import SwiftUI


    struct ContentView: View {
        //@State var homescreen = false;
        var body: some View {
            VStack (alignment: .center, spacing: 20){
                HomeView();
                    
                }
            }
            
    }

    struct HomeView: View {
        @State var homescreen = false;
        var body: some View {
            VStack (alignment: .center, spacing: 20){
                HeaderBarTitle(title: "HAPTICS", size: 20)
                if homescreen {
                    InstructionView()
                } else {
                    Button("Instructions") {
                        self.homescreen = true
                    }
                }
            }
            .padding()
            
            
            
        }
    }
    
    
    struct InstructionView: View {
        @State var instructions: String = "These are the instructions. "
        var body: some View {
            VStack (alignment: .center, spacing: 20){
                HeaderBarTitle(title: "Instructions", size: 20)
                TextField(
                            "Family Name",
                            text: $instructions
                        )
                
            }
            .padding()
            
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

