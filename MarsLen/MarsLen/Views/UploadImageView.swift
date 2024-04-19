//
//  UploadImageView.swift
//  MarsLen
//
//  Created by Simon Fong on 18/04/2024.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseDatabase

struct UploadImageView: View {
    
    @ObservedObject var profileModel = ProfileModel()
    @ObservedObject var profile = ProfileObj()
    @Environment(\.presentationMode) var presentationMode
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var loadImage: UIImage?
    
    @State private var isAlert: Bool = false
    @State private var alertMsg:String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                // if image selected
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 300)
                }
                
                // picker btn
                Button{
                    // show the image picker
                    isPickerShowing = true
                } label:{
                    Text("Select photo")
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
                
                // if selected image is not nil, upload button
                if selectedImage != nil {
                    Button{
                        // upload image
                        uploadPhoto()
                    } label: {
                        Text("Upload photo")
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
                }
                
                Divider()
                
//                if let dimg = loadImage{
//                    Image(uiImage: dimg)
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                }
            }
            
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            // image picker
            ImagePicker(
                selectedImage:$selectedImage,
                isPickerShowing: $isPickerShowing
            )
        } 
        .onAppear{
            print("=====onAppear")
//            retrievePhotos()
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
    
    
    func uploadPhoto(){
        
        // Check img is nil
        guard selectedImage != nil else{
            return
        }
        
        // create ref
        let storageRef = Storage.storage().reference()
        
        // convert img to data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        // check if convert good
        guard imageData != nil else {
            return
        }
        
        // specify target path
        let uid = profileModel.getCurrentUserID()!
        let path = "images/\(uid)/\(UUID().uuidString).jpg"
        
        let fileRef = storageRef.child(path)
        
        // upload data
        let uploadTask = fileRef.putData(imageData!, metadata: nil){
            metadata, error  in
            
            // check error
            if error == nil && metadata != nil{
                
                // save a ref to fb db
                profileModel.updateImageUrl(imgPath: path)
                print("========Uploaded path:\(path)")
                isAlert.toggle()
                alertMsg = "Upload success."
            }
        }
    }
    
    
    func retrievePhotos(){
        // get the path from the db
        profileModel.getProfile() // get profile
        let imgPath = profile.imgurl
        print("========retrivePhoto - Get imgpath: \(imgPath)")
        
        // load data from storage
        let storageRef = Storage.storage().reference()
        let imgRef = storageRef.child(imgPath)
        
        imgRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            print("========Error: \(error.debugDescription)")
            print("========Data: \(data == nil)")
            // check error
            if error == nil && data != nil{
                print("=====")
                if let image = UIImage(data: data!){
                    print("=====111")
                    // retieve data to main thread
                    DispatchQueue.main.async {
                        print("========append")
                        //                        retrievedImages.append(image)
                        
                    }
                }
            }
        }
    }
}


struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}
