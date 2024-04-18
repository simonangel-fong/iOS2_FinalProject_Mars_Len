//
//  MarsLenApp.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct MarsLenApp: App {
    
//    init(){
//        FirebaseApp.configure()
//    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            LandingView()
            ContentView()
                .environmentObject(AppModel())
        }
    }
}
