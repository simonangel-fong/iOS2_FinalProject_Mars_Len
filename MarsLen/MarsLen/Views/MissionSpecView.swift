//
//  MissionSpecView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

// A view to show specification
struct MissionSpecView: View {
    
    @EnvironmentObject var model: AppModel
    
    var body: some View {
        NavigationStack{
            VStack {
                  
                // mission image
                Image("\(model.rover_list[model.currentIndex].name)_3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width * 0.95)
                    .cornerRadius(20)
                
                // spec list
                List {
                    Section(header: Text("Objective(s)")) {
                        Text("\(model.rover_list[model.currentIndex].objective)")
                    }
                    
                    Section(header: Text("Spacecraft")) {
                        Text("\(model.rover_list[model.currentIndex].spacecraft)")
                    }
                    
                    Section(header: Text("Launch Date and Time")) {
                        Text("\(model.rover_list[model.currentIndex].launchDate)")
                    }
                    
                    Section(header: Text("Launch Site")) {
                        Text("\(model.rover_list[model.currentIndex].launchSite)")
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Specification", displayMode: .inline)
        }
    }
}

struct MissionSpecView_Previews: PreviewProvider {
    static var previews: some View {
        MissionSpecView()
            .environmentObject(AppModel())
    }
}
