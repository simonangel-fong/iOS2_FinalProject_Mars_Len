//
//  ProfileView.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI
import FirebaseStorage
import FirebaseDatabase

// A view of profile view
struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = UserModel()
    @ObservedObject var profileModel = ProfileModel()

    @State var profile: ProfileObj = profileObj
    @State var logoImg: UIImage?
    
    @State private var isAlert: Bool = false
    @State private var alertMsg:String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                
                VStack{
                    if let logoData = logoImg {
                        Image(uiImage: logoData)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .padding()
                            .clipShape(Circle())
                    }else{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    
                    Text(profile.nickname)
                        .font(.title)
                }
                
                
                // list of profile configuration views
                List {
                    // update nickname
                    NavigationLink(destination: NicknameView()) {
                        HStack {
                            Text("Update Nickname")
                        }
                    }
                    
                    // update logo
                    NavigationLink(destination: UploadImageView()) {
                        HStack {
                            Text("Update Image")
                        }
                    }
                }
                
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
            // Get profile data when appearing
            .onAppear {
                profileModel.getProfile()
                getLogo()
                
            }
            .navigationTitle("Astronaut Profile")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        logoImg = nil
                        user.logout()   // logout
//                        isAlert.toggle()
//                        alertMsg = "Logout success."
                        
                    }) {
                        Label("Back", systemImage: "arrow.left.circle")
                    }
                }
            }
            
        }
        .alert(isPresented: $isAlert, content: {
                    // Alert configuration
                    Alert(title: Text("Message"), message: Text(alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                        // Action to take when user clicks "Ok"
                        // Pop back the view
                        presentationMode.wrappedValue.dismiss()
                    }))
                })
    }
    
    func getLogo(){
        print("======== getLogo")
        // load data from storage
        let storageRef = Storage.storage().reference()
        let imgRef = storageRef.child(profile.imgurl)
        
        print(imgRef.description)
        
        imgRef.getData(maxSize: 5 * 1024 * 1024, completion: { data, error in
            
            if error == nil && data != nil{
                DispatchQueue.main.async {
                    self.logoImg = UIImage(data: data!)
                    print("get logo")
                }
            }
        })
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
        ProfileView( )
        //            .environmentObject(AppModel())
    }
}
