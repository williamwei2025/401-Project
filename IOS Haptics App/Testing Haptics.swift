//
//  Testing Haptics.swift
//  IOS Haptics App
//
//  Created by user229725 on 11/14/22.
//
import "AccSynthHashMatrixWrapper.hpp"
import "HelloWorldWrapper.h"

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        
        //Text("Hello, world!").padding()
        
        let model = AccSynthHashMatrix(3, 1.0, 1.0);	      T
        print("Initialization Success")
        
        model.HashAndInterp2(1.0, 1.0)
        let BC1 = model.BC1;
        let BC2 = model.BC2;
        let BC3 = model.BC3;
        
    }
}
