//
//  AppModel.swift
//  MarsLen
//
//  Created by Simon Fong on 17/04/2024.
//

import Foundation
import UIKit

// MARK: - structs for decode json from API

// A data model of camera
struct camera: Codable, Identifiable {
    
    let id = UUID()
    let name:String
    let full_name:String
}

// A data model of one Photo
struct photo:Codable, Identifiable{
    let id = UUID()
    let sol: Int
    let img_src:String
    let earth_date:String
    let camera:camera
}

// A data model of photo list to decode Json
struct photoModel:Codable, Identifiable{
    let id = UUID()
    let photos:[photo]?
}

// A data model of one rover
struct rover:Codable, Identifiable{
    let id = UUID()
    var name:String?
    var landing_date:String?
    var launch_date:String?
    var status:String?
    var max_sol:Int?
    var max_date:String?
    var total_photos:Int?
}

// A data model of rover info to decode Json
class roverModel: Codable{
    let id = UUID()
    var photo_manifest: rover?
}


// MARK: - The model of this app
class AppModel: ObservableObject{
    
    // api key, https://github.com/corincerami/mars-photo-api
    let apiKey:String = "5C08Y7HRRUzGstgdgPG8V1w9AjTuBn1PJFz6p0kP"
    
    var camIndex:Int = 1        // selected camera index
    let cam_list:[String] = ["RHAZ", "NAVCAM","FHAZ"]   // camera list
    
    var currentIndex:Int = 0    // selected rover
    
    // A list of rover with basic info
    let rover_list:[RoverObj] = [
        // Curiosity
        RoverObj(
            name: "Curiosity",
            objective: "Examining Mars' environment",
            spacecraft: "Mars Science Laboratory",
            launchDate: "November 26, 2011 at 10:02 a.m. EST",
            launchSite: "Cape Canaveral (CCAFS)",
            metaData: [
                MetaData(id: 0, key: "STATUS", value: "ACTIVE", logo: "checkmark.circle"),
                MetaData(id: 1, key: "MAX SOL", value: "4126", logo: "flame"),
                MetaData(id: 2, key: "LAUNCH", value: "Nov. 26, 2011", logo: "arrow.up.circle"),
                MetaData(id: 3, key: "LANDING", value: "Aug. 6, 2012", logo: "arrow.down.circle"),
            ],
            info:"NASA's Curiosity rover embarked on a groundbreaking mission to explore the Martian surface, focusing on geological studies and the search for habitable environments. Curiosity's expedition has been marked by remarkable achievements, including the discovery of ancient lake beds and organic molecules, shedding light on Mars' past potential for life. \n\nOperating for over nine years, surpassing its initial mission duration, Curiosity has traveled approximately 16.1 kilometers (10 miles) across the Martian landscape. \n\nDespite encountering technical challenges, Curiosity continues to provide invaluable data, pushing the boundaries of our understanding of the Red Planet."
        ),
        // Opportunity
        RoverObj(
            name: "Opportunity",
            objective: "Mars Surface Exploration",
            spacecraft: "Mars Exploration Rover 2 (MER2)",
            launchDate: "June 10, 2003 / 10:58:47 PDT",
            launchSite: "Cape Canaveral, Florida / SLC-17A",
            metaData: [
                MetaData(id: 0, key: "STATUS", value: "MISSION END", logo: "checkmark.circle" ),
                MetaData(id: 1, key: "MAX SOL", value: "5498", logo: "flame"),
                MetaData(id: 2, key: "LAUNCH", value: "Jul. 7, 2003", logo: "arrow.up.circle"),
                MetaData(id: 3, key: "LANDING", value: "Jan. 24, 2004", logo: "arrow.down.circle"),
            ],
            info:"NASA's Opportunity rover, alongside its counterpart Spirit, extensively researched the past climate and presence of water at various Martian locations, potentially conducive to life. \n\nOpportunity's mission concluded after an impressive tenure, lasting over 15 years, significantly surpassing its planned operational duration. Traversing approximately 28 miles (45 kilometers) across the Martian terrain, Opportunity played a crucial role in enhancing our understanding of the Red Planet. \n\nDespite NASA's efforts to reestablish communication, Opportunity fell silent in June 2018, marking the end of its remarkable journey."
        ),
        // Spirit
        RoverObj(
            name: "Spirit",
            objective: "Mars Surface Exploration",
            spacecraft: "Mars Exploration Rover 2 (MER2)",
            launchDate: "June 10, 2003 / 10:58:47 PDT",
            launchSite: "Cape Canaveral, Florida / SLC-17A",
            metaData: [
                MetaData(id: 0, key: "STATUS", value: "MISSION END", logo: "checkmark.circle"),
                MetaData(id: 1, key: "MAX SOL", value: "2208", logo: "flame"),
                MetaData(id: 2, key: "LAUNCH", value: "Jun. 10, 2003", logo: "arrow.up.circle"),
                MetaData(id: 3, key: "LANDING", value: "Jan. 3, 2004", logo: "arrow.down.circle"),
            ],
            info: "NASA's Spirit rover—and it's twin Opportunity—studied the history of climate and water at sites on Mars where conditions may once have been favorable to life.\n\nSpirit uncovered strong evidence that Mars was once much wetter than it is now.\n\nDescribed as a 'wonderful workhorse'—Spirit operated for 6 years, 2 months, and 19 days, more than 25 times its original intended lifetime.\n\nThe rover traveled 4.8 miles (7.73 kilometers) across the Martian plains.\n\nOn May 25, 2011, NASA ended efforts to contact the marooned rover and declared its mission complete. The rover had been silent since March 2010."
        ),
    ]
    
    /// Function to decode Json into target type
    func decodePhotoJson(data:Data)-> photoModel{
        print("=========decode photo json")
        return try! JSONDecoder().decode(
            photoModel.self,
            from: data
        )
    }
    
    /// Function to decode Json into target type
    func decodeRoverJson(data:Data)-> roverModel{
        print("=========decode rover json")
        return try! JSONDecoder().decode(
            roverModel.self,
            from: data
        )
    }
    
    /// Function to convert data into UIImage
    func toImage(data:Data)-> UIImage?{
        print("=========conver UIImage")
        return UIImage(data:data)
    }
    
    /// function to get photo
    func getPhotoList(camIndex:Int, completion: @escaping(photoModel) -> ()){
        guard let url = URL(string:
                                "https://api.nasa.gov/mars-photos/api/v1/rovers/\(self.rover_list[self.currentIndex].name)/photos?api_key=\(self.apiKey)&sol=100&camera=\(self.cam_list[camIndex])"
                            
        ) else {
            print("========Invalid URL")
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            let photoList = try! self.decodePhotoJson(data: data!)
            print("========GetPhotos")
            
            DispatchQueue.main.async {
                completion(photoList)
            }
        }
        .resume()
    }
    
    /// function to load image data
    func loadImageData(from urlString: String, completion: @escaping(UIImage) -> ()) {
        guard let url = URL(string: urlString) else {
            print("========Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            guard let data = data, err == nil else {
                print("========Failed to download image:", err?.localizedDescription ?? "Unknown error")
                return
            }
            
            DispatchQueue.main.async {
                
                if let imgData = self.toImage(data: data) {
                    print("========Get Image")
                    completion(imgData)
                }
//                let imgData = self.toImage(data: data)
//                completion(imgData)
            }
        }.resume()
    }
}

// A class to define meta data for each rover
class MetaData{
    var id : Int
    var key : String
    var value : String
    var logo : String
    
    init(id: Int, key: String, value: String, logo: String) {
        self.id = id
        self.key = key
        self.value = value
        self.logo = logo
    }
    
}

// A class to represent a rover in AppModel
class RoverObj{
    var name:String
    var info:String
    var metaData:[MetaData]
    var objective: String
    var spacecraft: String
    var launchDate: String
    var launchSite: String
    
    init(name: String, objective:String, spacecraft:String, launchDate:String, launchSite:String, metaData:[MetaData], info:String) {
        self.name = name
        self.metaData = metaData
        self.info = info
        self.objective = objective
        self.spacecraft = spacecraft
        self.launchDate = launchDate
        self.launchSite = launchSite
    }
}


let appModel = AppModel()  // instance for testing
