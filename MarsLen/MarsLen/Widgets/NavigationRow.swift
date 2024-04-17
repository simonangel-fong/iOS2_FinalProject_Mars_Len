//
//  NavigationRow.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

struct NavigationRow<Destination: View>: View {
    var title: String
    var destView: Destination
    
    var body: some View {
        NavigationLink(destination: destView) {
            HStack {
                Text(title)
                Spacer()
                Text("Detail")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            .padding()
        }
    }
}

struct NavigationRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationRow(title: "Title", destView: MissionInfoView())
    }
}
