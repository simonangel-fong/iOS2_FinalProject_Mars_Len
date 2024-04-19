//
//  ProfileImg.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI
import FirebaseStorage
import FirebaseDatabase

// A wedget to display profile image
struct ProfileImg: View {
    
    @ObservedObject var profile_Model = profileModel
    @ObservedObject var profile = profileObj
    
    var imgUrl: String // Variable for image URL
    var nickname: String // Variable for nickname
    @State var isRemote: Bool = false
    @State var imgData: UIImage?
    
    var body: some View {
        VStack {
            // if firestore is not available.
            if !isRemote{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
            }else{
                Image(uiImage: imgData!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
            }
            Text(nickname)
                .font(.title)
        }
        .onAppear{
            print("======ProfileImg - onAppear")
            getLogo(imagePath: imgUrl)
        }
    }
    
    func getLogo(imagePath:String){
        print("======== getLogo - imagePath:\(imagePath)")
        // load data from storage
        let storageRef = Storage.storage().reference()
        let imgRef = storageRef.child(imagePath)
        
        print(imgRef.description)
        
        imgRef.downloadURL{ url, error in
            if let error = error {
                // Handle any errors
            } else {
                print(url)
            }
        }
    }
}


struct ProfileImg_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImg(imgUrl: "images/miWBea0WJBbCNvCzIZaMZgHIJPh1/C8582778-81B4-424F-8020-B47807BBAD87.jpg", nickname: "John Doe")
    }
}
