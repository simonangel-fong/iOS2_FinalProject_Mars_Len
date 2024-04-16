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

class ProfileModel: ObservableObject{
    var ref = Database.database().reference()
    
    //    @Published
    //    var value: String? = nil
    
    @Published
    var data: ProfileObj? = nil
    
    //get current user id
    private func getCurrentUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    
    func getProfile(){
        if let userID = getCurrentUserID(){
            
            print("\(userID)")
            let profileRef = ref.child("profile")
            let userRef = profileRef.child("\(userID)")
            userRef.observeSingleEvent(of: .value){ snapshot in
                do{
                    print("==========get profile")
                    self.data = try snapshot.data(as: ProfileObj.self)
                    profileObj.nickname = self.data!.nickname
                    profileObj.email = self.data!.email
                    profileObj.imgurl = self.data!.imgurl
                }catch{
                    print("===========can not convert to Object")
                }
            }
        }
    }
    
    func create(){
        print("=========create profile")
        if let userID = getCurrentUserID(){
            let profileRef = ref.child("profile")
            let profile = [
                "email": Auth.auth().currentUser?.email,
                "nickname": Auth.auth().currentUser?.email,
                "imgurl": "person.circle.fill"
            ]
            let childUpdates = ["/profile/\(userID)": profile]
            ref.updateChildValues(childUpdates)
            print("=========profile updated")
        }
    }
    
    
    //    func readValue(){
    //        if let userID = getCurrentUserID(){
    //            let profileRef = ref.child("profile")
    //            let userRef = profileRef.child("\(userID)")
    //
    //            userRef.observeSingleEvent(of: .value){snapshot in
    //                self.value = snapshot.value as? String
    //                print("\(self.value)=============")
    //            }
    //        }
    //    }
}





