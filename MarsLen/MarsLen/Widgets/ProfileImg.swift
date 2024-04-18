//
//  ProfileImg.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import SwiftUI

// A wedget to display profile image
struct ProfileImg: View {
    var imgUrl: String // Variable for image URL
    var nickname: String // Variable for nickname
    
    var body: some View {
        VStack {
            Image(systemName: imgUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            Text(nickname)
                .font(.title)
        }
    }
}

struct ProfileImg_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImg(imgUrl: "person.circle.fill", nickname: "John Doe")
    }
}
