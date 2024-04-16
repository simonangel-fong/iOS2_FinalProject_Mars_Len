//
//  ProfileObj.swift
//  MarsLen
//
//  Created by Simon Fong on 16/04/2024.
//

import Foundation
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
