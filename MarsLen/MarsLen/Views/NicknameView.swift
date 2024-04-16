//
//  NicknameView.swift
//  MarsLen
//
//  Created by Simon Fong on 16/04/2024.
//

import SwiftUI

struct NicknameView: View {
    
    @ObservedObject var profileModel = ProfileModel()
    @ObservedObject var profile: ProfileObj = profileObj
    
    var body: some View {
        NavigationView{
            // MARK: - nickname textfield
            let emailInputField = HStack {
                Image("user-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 30,
                        height: 30.0
                    )
                    .opacity(0.5)
                
                let emailTextField = TextField(
                    "Nickname",
                    text: $profile.nickname
                )
                
                emailTextField
    //                .keyboardType(.emailAddress)
                    .autocapitalization(UITextAutocapitalizationType.none)
            }
                .padding(0.02 * ScreenDim.height)
            
            emailInputField.background(
                RoundedRectangle(cornerRadius:10)
                    .fill(Color(.systemGray5))
            ).frame(width: ScreenDim.width * 0.8)
        }
        .navigationBarTitle("Update Nickname")
    }
}

#Preview {
    NicknameView()
}
