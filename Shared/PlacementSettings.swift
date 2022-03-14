////
////  PlacementSettings.swift
////  FindAR
////
////  Created by Dev Patel on 2/23/22.
////
//
//import SwiftUI
//import RealityKit
//import Combine
//
//
//class PlacementSettings: ObservableObject{
//    @Published var selectedModel: Model? {
//        willSet(newValue){
//            print("settings selectedModel to \(String(describing: newValue?.name))")
//        }
//    }
//    
//    @Published var confirmedModel: Model? {
//        willSet(newValue){
//            guard let model=newValue else{
//                print("clearing confirmedModel")
//                return
//            }
//        }
//    }
//    
//    var sceneObserver: Cancellable?
//    
//}
