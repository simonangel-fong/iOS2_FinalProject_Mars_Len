//
//  MarsLenApp.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI
import Firebase

@main
struct MarsLenApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            LandingView()
            ContentView()
                .environmentObject(AppModel())
        }
    }
}
