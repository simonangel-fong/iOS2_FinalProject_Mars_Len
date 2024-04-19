//
//  ProfileModel.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

// This is a model to implement profile on Firebase real time database
class ProfileModel: ObservableObject{
    
    /// DB ref
    var ref = Database.database().reference()
    
    @Published
    var data: ProfileObj? = nil
    
    //get current user id
//    private func getCurrentUserID() -> String? {
    func getCurrentUserID() -> String? {
        let userID = Auth.auth().currentUser?.uid
        print("==========Get UID: \(userID)")
        return userID
    }
    
    
    // get profile from firebase
    func getProfile(){
        if let userID = getCurrentUserID(){
            
            print("\(userID)")
            let profileRef = ref.child("profile")
            let userRef = profileRef.child("\(userID)")
            userRef.observeSingleEvent(of: .value){ snapshot in
                do{
                    // if exists
                    print("========profile exist: \(snapshot.exists())")
                    if snapshot.exists() {
                        print("==========get profile")
                        self.data = try snapshot.data(as: ProfileObj.self)
                        profileObj.nickname = self.data!.nickname
                        profileObj.email = self.data!.email
                        profileObj.imgurl = self.data!.imgurl
                        print("==========get nickname: \(profileObj.nickname)")
                        print("==========get email: \(profileObj.email)")
                        print("==========get imgurl: \(profileObj.imgurl)")
                    }else{
                        self.create()
                        self.getProfile()
                    }
                }catch{
                    print("===========can not convert to Object")
                }
            }
        }
    }
    
    // A functiion to create a profile based on an authenticated user.
    func create(){
        print("=========create profile")
        if let userID = getCurrentUserID(){
            let profileRef = ref.child("profile")
            let profile = [
                "email": Auth.auth().currentUser?.email,
                "nickname": Auth.auth().currentUser?.email,
                "imgurl": ""  // by default is empty
            ]
            let childUpdates = ["/profile/\(userID)": profile]
            ref.updateChildValues(childUpdates)
            print("=========profile updated")
        }
    }
    
    //     A functiion to update profile info on firebase.
    func updateNickname(nickname: String) -> String{
        if let userID = getCurrentUserID(){
            // get ref
            let profileRef = self.ref.child("profile/\(userID.description)/nickname")
            do{
                try profileRef.setValue(nickname)
                return ""
            }
            catch let error as NSError {
                print("Error signing out: \(error.localizedDescription)")
                return error.localizedDescription
            }
            
        }else{
            return "update nickname fails!"
        }
    }
    
    // update image url
    func updateImageUrl(imgPath: String) -> String{
        if let userID = getCurrentUserID(){
            // get ref
            let profileRef = self.ref.child("profile/\(userID.description)/imgurl")
            do{
                try profileRef.setValue(imgPath)
                return ""
            }
            catch let error as NSError {
                print("Error signing out: \(error.localizedDescription)")
                return error.localizedDescription
            }
            
        }else{
            return "update nickname fails!"
        }
    }
}


// a class to decode firebase data
class ProfileObj: Encodable, Decodable, ObservableObject{
    
    var email = ""
    var nickname = ""
    var imgurl = ""
    
    //    init(){}
    
    init(email: String = "", nickname: String = "", imgurl: String = "") {
        self.email = email
        self.nickname = nickname
        self.imgurl = imgurl
    }
}

let profileObj = ProfileObj(email:"", nickname: "", imgurl: "")
let profileModel = ProfileModel()
