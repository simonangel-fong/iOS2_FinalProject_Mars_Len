//
//  PhotoView.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

// A view to display image
struct PhotoView: View {
    
    @EnvironmentObject var model: AppModel
    @State var photoData:photo
    @State private var downloadedImage: UIImage?
    
    var body: some View {
        NavigationStack{
            VStack{
                // show image if get image data
                if let image = downloadedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenDim.width)
                        .padding()
                } else {
                    // otherwise, show default
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenDim.width)
                        .padding()
                        .onAppear {
                            
                            print("Image Url:\(photoData.img_src)")
                            
                            /// call function download image data
                            model.loadImageData(from: photoData.img_src) { img in
                                downloadedImage = img       // update img
                                print(downloadedImage)
                            }
                        }
                    
                }
                
                // image details
                List {
                    Section(header: Text("Earth Date")) {
                        Text(photoData.earth_date)
                    }
                    
                    Section(header: Text("Sol Date")) {
                        Text("\(photoData.sol)")
                    }
                    
                    Section(header: Text("Camera")) {
                        Text("\(photoData.camera.full_name)")
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 20)
                .onAppear(
                    
                )
            }
            .navigationBarTitle("Mission Photo", displayMode: .inline)
        }
    }
}

struct PhotoView_PreviewView:PreviewProvider {
    static var previews: some View{
        let phObj = photo(
        sol: 100,
        img_src: "http://mars.nasa.gov/mer/gallery/all/2/f/001/2F126468064EDN0000P1001R0M1-BR.JPG",
        earth_date: "2010-10-10",
        camera: camera(name: "FHAZ", full_name: "Front Camera"))
        
        PhotoView(photoData:phObj)
            .environmentObject(AppModel())
    }
}
