//
//  Content.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isSignedIn") var isSignedIn = false
    @ObservedObject var profileObj: ProfileObj = ProfileObj()
    
    var body: some View {
        
        if isSignedIn{
            // when is singed in, goes to profile view
            ProfileView()
                .environmentObject(AppModel())
        }else {
            // when is not, goes to login
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(ProfileModel())
    }
}
