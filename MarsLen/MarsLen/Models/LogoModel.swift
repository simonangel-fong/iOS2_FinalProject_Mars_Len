//
//  LogoModel.swift
//  MarsLen
//
//  Created by Simon Fong on 18/04/2024.
//

import Foundation
import FirebaseStorage
import SwiftUI

class FirebaseImageUploader: ObservableObject {
    // Reference to Firebase Storage
    private let storage = Storage.storage()
    
    // Function to upload an image to Firebase Storage
    func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        // Create a reference to the storage bucket
        let storageRef = storage.reference()
        
        // Create a unique identifier for the image file
        let uniqueImageName = UUID().uuidString
        
        // Create a reference to the image in the "images" folder
        let imageRef = storageRef.child("images/\(uniqueImageName).jpg")
        
        // Convert the UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "Image conversion failed", code: -1, userInfo: nil)))
            return
        }
        
        // Upload the image data to Firebase Storage
        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                // If there's an error during the upload, return the error
                completion(.failure(error))
                return
            }
            
            // Once the upload is complete, retrieve the download URL
            imageRef.downloadURL { url, error in
                if let error = error {
                    // If there's an error getting the download URL, return the error
                    completion(.failure(error))
                } else if let url = url {
                    // If the URL is retrieved successfully, return the URL
                    completion(.success(url))
                }
            }
        }
    }
}
