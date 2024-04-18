//
//  MissionView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

// A view of each mission
struct MissionView: View {
    
    @EnvironmentObject var model: AppModel
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                // image
                Image("\(model.rover_list[model.currentIndex].name)_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width * 0.95)
                    .cornerRadius(25)
                
                // detail info list
                List{
                    NavigationRow(
                        title: "Mission Information",
                        destView: MissionInfoView())
                    NavigationRow(
                        title: "Specification",
                        destView: MissionSpecView())
//                    NavigationRow(
//                        title: "Science Discovery",
//                        destView: MissionDiscoveryView())
//                    NavigationRow(
//                        title: "Video",
//                        destView: MissionVideoView())
                    NavigationRow(
                        title: "Gallery",
                        destView: MissionGalleryView())
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle(" \(model.rover_list[model.currentIndex].name)", displayMode: .inline)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
            .environmentObject(AppModel())
    }
}

