//
//  FindARApp.swift
//  Shared
//
//  Created by Dev Patel on 2/4/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct FindARApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            let viewModel = SignIn()

            ContentView()
                .environmentObject(viewModel)
        }
    }
    
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
        
        func application(_ application: UIApplication, open url: URL,
                         options: [UIApplication.OpenURLOptionsKey: Any])
          -> Bool {
          return GIDSignIn.sharedInstance.handle(url)
        }
    }
    
    
    
    
    
}
