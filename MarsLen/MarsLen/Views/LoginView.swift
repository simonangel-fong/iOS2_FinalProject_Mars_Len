//
//  LoginView.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI
import SceneKit

struct LoginView: View {
    
    @StateObject var user = UserViewModel()
    @State private var signUpViewPresented = false
    
    var body: some View {
        
        VStack {
            Text("Astronaut login".uppercased())
                .font(.title2)
            
            // MARK: - 3D Object
            SceneView(
                scene: SCNScene(named: "Mars.usdz"),
                options: [
                    .autoenablesDefaultLighting,
                    .allowsCameraControl
                ])
            .background(Color.clear)
            .frame(
                width: ScreenDimensions.width * 0.9,
                height: ScreenDimensions.width * 0.9)
            
            // MARK: - Email textfield
            let emailInputField = HStack {
                Image("user-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 30,
                        height: 30.0
                    )
                    .opacity(0.5)
                
                let emailTextField = TextField(
                    "Email",
                    text: $user.email
                )
                
                emailTextField
                    .keyboardType(.emailAddress)
                    .autocapitalization(UITextAutocapitalizationType.none)
                }
                .padding(0.02 * ScreenDimensions.height)
            
            emailInputField.background(
                RoundedRectangle(cornerRadius:10)
                    .fill(Color(.systemGray5))
            )
            .frame(width: ScreenDimensions.width * 0.8)
            
            // MARK: -password textfield
            let passwordInputField = HStack {
                Image("lock-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
                    .opacity(0.5)
                SecureField("Password", text: $user.password)
            }
                .padding(0.02 * ScreenDimensions.height)
            
            passwordInputField
                .background(
                    RoundedRectangle(cornerRadius:10)
                        .fill(Color(.systemGray5))
                )
                .frame(width: ScreenDimensions.width * 0.8)
            
            Spacer().frame(idealHeight: 0.05 * ScreenDimensions.height).fixedSize()
            
            // MARK: - login button
            let loginButton = Button(action: user.login) {
                
                Text("Login".uppercased())
                    .foregroundColor(.white)
                    .font(.title2).bold()
            }
                .padding(0.02 * ScreenDimensions.height)
                .background(
                    Capsule().fill(Color.primaryRed))
            
            loginButton.buttonStyle(BorderlessButtonStyle())
            
            Spacer().frame(idealHeight: 0.05 * ScreenDimensions.height).fixedSize()
            
            // MARK: - prompt sign up
            HStack {
                Text("Don't have an account?")
                let signUpButton = Button(action: {
                    signUpViewPresented = true
                }) {
                    Text("Sign Up".uppercased()).bold()
                }
                    .sheet(isPresented: $signUpViewPresented) {
                        SignUpView(user: user, isPresented: $signUpViewPresented)
                    }
                signUpButton.buttonStyle(BorderlessButtonStyle())
            }
        }.alert(isPresented: $user.alert, content: {
            Alert(title: Text("Message"), message: Text(user.alertMessage), dismissButton: .destructive(Text("OK")))
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(user: user)
    }
}
