//
//  MissionGalleryView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

struct MissionGalleryView: View {
    
    @EnvironmentObject var model: AppModel
    @State var photoList:[photo]?
    
    @State var camIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack{
            //            Text("\(camIndex)")
            
            VStack{
                // title
                HStack {
                    Text("\(model.rover_list[model.currentIndex].name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primaryDark.opacity(0.7))
                        .padding(.leading)
                        .padding(.top)
                    Spacer(minLength: 0)
                }
                .padding(.bottom,20)
                
                
                // tab view
                HStack(spacing:0){
                    Text("RHAZ")
                        .foregroundColor(self.camIndex == 0 ? .white : .primaryWhite.opacity(0.8))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal,35)
                        .background(Color.secondaryRed.opacity(self.camIndex == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture{
                            withAnimation(.default){
                                self.camIndex = 0
                                model.camIndex = self.camIndex
                                // call load image
                                model.getPhotoList(camIndex:camIndex) { photoModel in
                                    photoList = photoModel.photos
                                }
                            }
                        }
                    
                    Spacer(minLength: 0)
                    
                    Text("NAV")
                        .foregroundColor(self.camIndex == 1 ? .white : .primaryWhite.opacity(0.7))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal,35)
                        .background(Color.secondaryRed.opacity(self.camIndex == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture{
                            withAnimation(.default){
                                self.camIndex = 1
                                model.camIndex = self.camIndex
                                // call load image
                                model.getPhotoList(camIndex:camIndex) { photoModel in
                                    photoList = photoModel.photos!
                                }
                            }
                        }
                    
                    Spacer(minLength: 0)
                    
                    // MARK: - Cam Indecator
                    Text("FHAZ")
                        .foregroundColor(self.camIndex == 2 ? .white : .primaryWhite.opacity(0.7))
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal,35)
                        .background(Color.secondaryRed.opacity(self.camIndex == 2 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture{
                            withAnimation(.default){
                                self.camIndex = 2
                                model.camIndex = self.camIndex
                                // call load image
                                model.getPhotoList(camIndex:camIndex) { photoModel in
                                    photoList = photoModel.photos
                                }
                            }
                        }
                }
                .background(Color.black.opacity(0.15))
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.top, 5)
                
                
                VStack {
                    ZStack{
                        ForEach(0..<model.rover_list.count, id: \.self){index in
                            Image("\(model.cam_list[index])")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:300, height:200)
                                .cornerRadius(25)
                                .opacity(
                                    camIndex == index ? 1.0 : 0.5)
                                .scaleEffect(
                                    camIndex == index ? 1.2 : 0.8)
                                .offset(
                                    x: CGFloat(index - camIndex) * 300 + dragOffset,
                                    y : 0)
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 5, y: 10)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded({value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold{
                                    withAnimation{
                                        camIndex = max(0, camIndex - 1)
                                        model.camIndex = self.camIndex
                                        
                                        // call load image
                                        model.getPhotoList(camIndex:camIndex) { photoModel in
                                            photoList = photoModel.photos
                                        }
                                    }
                                }else if value.translation.width < -threshold {
                                    withAnimation{
                                        camIndex = min(model.rover_list.count - 1, camIndex + 1)
                                        
                                        model.camIndex = self.camIndex
                                        // call load image
                                        model.getPhotoList(camIndex:camIndex) { photoModel in
                                            photoList = photoModel.photos
                                        }
                                    }
                                }
                            })
                    )
                }
                .padding(.vertical,30)
                
                
                if let phList = photoList{
                    List(phList) { photo in
                        HStack {
                            ImageRow(
                                model:model,
                                photoData: photo,
                                destView: PhotoView(photoData: photo)
                            )
                            
                        }
                    }
                    //                    .frame( maxWidth: .infinity)
                    //                    .edgesIgnoringSafeArea(.all)
                    .listStyle(PlainListStyle())
                }else{
                    Text("No data with this camera!")
                }
                
                Spacer()
            }
            .onAppear{
                model.getPhotoList(camIndex: camIndex) { photoModel in
                    photoList = photoModel.photos
                }
            }
            .navigationBarTitle("Gallery", displayMode: .inline)
        }
        
    }
}


struct MissionGalleryView_PreviewView:PreviewProvider {
    static var previews: some View{
        MissionGalleryView()
            .environmentObject(AppModel())
    }
}
