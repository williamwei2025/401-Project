    //
    //  HomeView.swift
    //  IOS Haptics App
    //
    //  Created by user228516 on 9/24/22.
    //

    import SwiftUI

    struct HomeView: View {
        
        init(){
            let x = AccSynthHashMatrixWrapper().test(3)
            print(x)
        }

        var body: some View {
            
            
            
            NavigationView{
                VStack (alignment: .center, spacing: 100){
                    HeaderBarTitle(title: HelloWorldWrapper().sayHello(), size: 40)
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

   
    
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }

