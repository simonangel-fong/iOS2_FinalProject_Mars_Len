//
//  ImageRow.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import SwiftUI

// A widget to display image row.
struct ImageRow<Destination: View>: View {
    
    @State var model = AppModel()
    @State var photoData:photo
    var destView: Destination
    
    @State private var downloadedImage: UIImage?
    
    var body: some View {
        NavigationLink(destination: destView) {
            HStack {
                if let image = downloadedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding()
                        .onAppear {
                            /// call function download image data
                            model.loadImageData(from: photoData.img_src) { img in
                                downloadedImage = img       // update img
                                print(downloadedImage)
                            }
                        }
                    
                }
                
                VStack(alignment: .leading){
                    Text(photoData.earth_date)
                        .font(.headline)
                    
                    Text("SOL \(photoData.sol)")
                        .font(.headline)
                    Text("Camera \(photoData.camera.name)")
                        .font(.headline)
                }
                .foregroundColor(Color.gray)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
    }
}

struct ContentView_ImageRow: PreviewProvider{
    static var previews: some View{
        let phObj = photo(
        sol: 100,
        img_src: "http://mars.nasa.gov/mer/gallery/all/2/f/001/2F126468064EDN0000P1001R0M1-BR.JPG",
        earth_date: "2010-10-10",
        camera: camera(name: "FHAZ", full_name: "Front Camera"))
        
        ImageRow(
            photoData:phObj ,
            destView: PhotoView(photoData: phObj)
        )
        
    }
}

