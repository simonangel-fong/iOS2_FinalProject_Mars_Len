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
            VStack{
                
                
                // MARK: - nickname textfield
                let nicknameTXF = HStack {
                    Image("user-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 30,
                            height: 30.0
                        )
                        .opacity(0.5)
                    
                    let textFiel = TextField(
                        "Nickname",
                        text: $profile.nickname
                    )
                    
                    textFiel
                        .autocapitalization(UITextAutocapitalizationType.none)
                }
                    .padding(0.02 * ScreenDim.height)
                
                nicknameTXF
                    .background(
                        RoundedRectangle(cornerRadius:10)
                            .fill(Color(.systemGray5))
                    )
                    .frame(width: ScreenDim.width * 0.8)
                    .padding(.top, 30)
                
                
                Button{
                    //
                } label:{
                    Text("update Nickname")
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.secondaryRed, .primaryBrown]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(10)
                }
                .shadow(
                    color: Color.secondaryBrown.opacity(0.8),
                    radius: 5, x: 2, y: 2)
                .padding(.top, 30)
                
                
                Spacer()
            }
            .navigationBarTitle(
                "Update Nickname" ,
                displayMode: .inline
            )
        }
    }
}

#Preview {
    NicknameView()
}
