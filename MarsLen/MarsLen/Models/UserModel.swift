//
//  UserViewModel.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth


// This is a model to implement authentication
class UserModel: ObservableObject {
    
    //User defaults
    @AppStorage("isSignedIn") var isSignedIn = false
    
    //email, password, alert message
    @Published var email = ""
    @Published var password = ""
    @Published var alert = false
    @Published var alertMessage = ""
    
    // Function to show alert message
    private func showAlertMessage(message: String)
    {
        alertMessage = message
        alert.toggle() //show the alert with a message
    }
    
    // Function to login with Firebase
    func login() {
        
        if email.isEmpty || password.isEmpty {
            print("email or pwd empty")
            showAlertMessage(message: "Neither email nor password can be empty")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.alert.toggle()
                print("============Sign in fails: \(self.alertMessage)")
            } else {
                self.isSignedIn = true
                print("============Signed in")
            }
        }
    }
    
    // Function to signup with Firebase
    func signUp() {
        
        if email.isEmpty || password.isEmpty {
            print("email or pwd empty")
            showAlertMessage(message: "Neither email nor password can be empty.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            if let err = err {
                self.alertMessage = err.localizedDescription
                self.alert.toggle()
                print("============Sign up fail: \(self.alertMessage)")
            } else {
                print("============Signed up")
            }
        }
    }
    
    // Function to log out Firebase
    func logout() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
            email = ""
            password = ""
            print("========Logout")
        } catch {
            print("Error signing out")
        }
    }
}

let user = UserModel() // instance
