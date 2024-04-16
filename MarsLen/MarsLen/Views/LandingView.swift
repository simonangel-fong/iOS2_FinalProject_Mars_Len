//
//  LandingView.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI

struct LandingView: View {
    @State private var backgroundImageOffset: CGFloat = -200 // Initial offset to hide the image outside the screen
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image with Animation
                Image("Welcome_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: backgroundImageOffset) // Apply the offset
                    .onAppear {
                        withAnimation(.easeInOut(duration: 10)) {
                            backgroundImageOffset = 50
                        }
                    }
                
                VStack {
                    Text("Mars Len")
                        .font(.system(size:50))
                        .fontWeight(.bold)
                        .foregroundColor(Color.secondaryDark.opacity(0.8))
                        .padding(.top, UIScreen.main.bounds.height * 0.2)
                        .shadow(
                            color: Color.primaryRed.opacity(0.8), /// shadow color
                            radius: 5, /// shadow radius
                            x: -5, /// x offset
                            y: 5 /// y offset
                        )
                    
                    Spacer()
                    
                    // Navigation to Mars3DView
                    NavigationLink(
                        destination: LoginView()
                    ) {
                        Text("Start Mars Advanture")
                            .font(.system(size: 18))
                            .foregroundColor(Color.secondaryDark)    // font color
                            .frame(
                                width: UIScreen.main.bounds.width * 0.75, height: 40)
                            .background(Color.secondaryWhite.opacity(0.6))    // btn bg
                            .cornerRadius(17)
                    }
                    .shadow(
                        color: Color.secondaryBrown.opacity(0.5),
                        radius: 10, x: 5, y: 5)
                    .padding(.bottom, 20
                    )
                }
            }
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
