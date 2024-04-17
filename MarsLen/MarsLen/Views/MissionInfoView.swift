//
//  MissionInfoView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

struct MissionInfoView: View {
    
    @EnvironmentObject var model: AppModel
    
    var body: some View {
        NavigationStack{
            VStack {
                
                // image
                Image("\(model.rover_list[model.currentIndex].name)_2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width * 0.95)
                    .cornerRadius(30)
                
                ScrollView {
                    Text("\(model.rover_list[model.currentIndex].info)")
                        .font(.system(size:20))
                        .padding(20)
                }
            }
            .navigationBarTitle("Mission Information", displayMode: .inline)
        }
    }
}

struct MissionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MissionInfoView()
            .environmentObject(AppModel())
    }
}
