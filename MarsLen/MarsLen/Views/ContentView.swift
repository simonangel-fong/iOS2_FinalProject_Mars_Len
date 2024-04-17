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
//                        NavigationView{
            ProfileView()
                .environmentObject(AppModel())
//                        }.environmentObject(ProfileModel())
        }else {
            //            NavigationView{
            LoginView()
            //            }.environmentObject(ProfileModel())
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProfileModel())
    }
}
