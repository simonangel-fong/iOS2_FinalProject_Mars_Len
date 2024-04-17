//
//  PhotoView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

struct PhotoView: View {
    
    @EnvironmentObject var model: AppModel
    
    var body: some View {
        NavigationStack{
            Text("\(model.camIndex)")
            VStack{
                // title
                HStack {
                    Text("Mission Photo")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primaryDark.opacity(0.7))
                        .padding(.leading)
                        .padding(.top)
                    Spacer(minLength: 0)
                }
                .padding(.bottom,20)
                
                // image
                Image("sample01")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width)
                    .cornerRadius(25)
                
                // spec list
                List {
                    Section(header: Text("Earth Date")) {
                        Text("2010-01-01")
                    }
                    
                    Section(header: Text("Spacecraft")) {
                        Text("Mars Exploration Rover 2 (MER2)")
                    }
                    
                    Section(header: Text("Launch Date and Time")) {
                        Text("June 10, 2003 / 10:58:47 PDT")
                    }
                    
                    Section(header: Text("Launch Site")) {
                        Text("Cape Canaveral, Florida / SLC-17A")
                    }
                    
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 20)
                .onAppear(
                    
                )
            }
        }
    }
}

struct PhotoView_PreviewView:PreviewProvider {
    static var previews: some View{
        PhotoView()
            .environmentObject(AppModel())
    }
}
