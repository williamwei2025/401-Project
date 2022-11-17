//
//  Program.swift
//  IOS Haptics App
//
//  Created by Grace Shan on 11/16/22.
//

import Foundation

class Program {
    
    private let speed = 0
    
    func callAPI() {
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            <#code#>
            //using speed, call the api
            //update the gloabl haptic after calling the api
        }
    }
    
    func monitorAndPlay() {
        let globalQueue = DispatchQueue.global()
        globalQueue.async {
            //update speed
            //play the gloabl haptic
        }
    }
}
