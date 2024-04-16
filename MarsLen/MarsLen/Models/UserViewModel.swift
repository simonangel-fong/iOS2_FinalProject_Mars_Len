//
//  UserViewModel.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

class UserViewModel: ObservableObject {
    
    //User defaults
    @AppStorage("isSignedIn") var isSignedIn = false
    
    //email, password, alert message
    @Published var email = ""
    @Published var password = ""
    @Published var alert = false
    @Published var alertMessage = ""
    
    private func showAlertMessage(message: String)
    {
        alertMessage = message
        alert.toggle() //show the alert with a message
    }
    
    func login() {
        
        if email.isEmpty || password.isEmpty {
            showAlertMessage(message: "Neither email nor password can be empty")
            
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.alert.toggle()
            } else {
                self.isSignedIn = true
            }
        }
    }
    
    func signUp() {
        
        if email.isEmpty || password.isEmpty {
            showAlertMessage(message: "Neither email nor password can be empty.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.alert.toggle()
            } else {
                self.login()
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
            email = ""
            password = ""
        } catch {
            print("Error signing out")
        }
    }
}

///Create this object and init
let user = UserViewModel()
