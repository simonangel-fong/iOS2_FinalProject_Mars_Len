//
//  MissionListView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

// A view display different mission
struct MissionListView: View {
    
    @EnvironmentObject var model: AppModel
//    var model = appModel
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Spacer()
                
                // image slide
                ZStack{
                    ForEach(0..<model.rover_list.count, id: \.self){index in
                        Image("\(model.rover_list[index].name)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.65,
                                   height: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.05)
                            .cornerRadius(30)
                            .opacity(
                                currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(
                                currentIndex == index ? 1.2 : 0.8)
                            .offset(
                                x: CGFloat(index - currentIndex) * 300 + dragOffset,
                                y : 0)
                            .shadow(color: Color.black.opacity(0.7), radius: 8, x: 8, y: 8)
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded({value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold{
                                withAnimation{
                                    currentIndex = max(0, currentIndex - 1)
                                    model.currentIndex = self.currentIndex
                                }
                            }else if value.translation.width < -threshold {
                                withAnimation{
                                    currentIndex = min(model.rover_list.count - 1, currentIndex + 1)
                                    model.currentIndex = self.currentIndex
                                }
                            }
                        })
                )
                
                Spacer()
                
                // btn
                NavigationLink(
                    destination: MissionView()
                ) {
                    Text("Select Mission")
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.secondaryRed, .primaryBrown]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(10)
                }
                .shadow(
                    color: Color.secondaryBrown.opacity(0.8),
                    radius: 5, x: 2, y: 2)
                .padding(.bottom, 5)
            }
            .navigationBarTitle("Mission \(model.rover_list[model.currentIndex].name)", displayMode: .inline)
        }

    }
}

struct RoverListView_Previews: PreviewProvider{
    static var previews: some View{
        MissionListView()
            .environmentObject(AppModel())
    }
}
