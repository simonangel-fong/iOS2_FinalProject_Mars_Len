//
//  ProfileView.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var user = UserModel()
    @ObservedObject var profileModel = ProfileModel()
    @ObservedObject var profile: ProfileObj = profileObj
    
    var body: some View {
        NavigationStack{
            VStack{
                ProfileImg(
                    imgUrl: profile.imgurl,
                    nickname: profile.nickname)
                
//                List {
//                    NavigationLink(destination: NicknameView()) {
//                        HStack {
//                            Text("Nickname")
//                        }
//                    }
//                    
//                    NavigationLink(destination: UploadImageView()) {
//                        HStack {
//                            Text("Update Image")
//                        }
//                    }
//                }
                
                Spacer()
                
                // Start butn
                NavigationLink(
                    destination: MissionListView()
                ) {
                    Text("Start Mars Advanture")
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
                .padding()
                
            }
            .onAppear {
                profileModel.getProfile()
                //            profileModel.create()
            }
            .navigationTitle("Profile")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        user.logout()   // logout
                        dismiss()       // dismiss current
                    }) {
                        Label("Back", systemImage: "arrow.left.circle")
                    }
                }
            }
        }
    }
}

struct UploadImageView: View {
    var body: some View {
        Text("Upload Image View")
            .navigationBarTitle("Update Image")
    }
}

struct ProfileView_Previews: PreviewProvider {
    //    static var exampleProfile = ProfileObj(
    //        email: "abc@abc.com",
    //        nickname: "abc@abc.com",
    //        imgurl: ""
    //    )
    static var previews: some View {
        //        ProfileView(profileObj: exampleProfile)
        ProfileView()
        //            .environmentObject(AppModel())
    }
}
