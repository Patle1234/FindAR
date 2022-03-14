//
//  FindARApp.swift
//  Shared
//
//  Created by Dev Patel on 2/4/22.
//

import SwiftUI
import Firebase

@main
struct FindARApp: App {
//    @StateObject var placemenetSettings=PlacementSettings()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            let viewModel = SignIn()

            ContentView()
                .environmentObject(viewModel)
//                .environmentObject(placemenetSettings)
        }
    }
    
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
    }
    
    
    
    
    
}
