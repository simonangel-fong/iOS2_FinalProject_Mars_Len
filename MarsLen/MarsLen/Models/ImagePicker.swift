//
//  ImagePicker.swift
//  MarsLen
//
//  Created by Simon Fong on 18/04/2024.
//
import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        // define the listener listening to the img picker
        imagePicker.delegate = context.coordinator  
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
    }
    
    // create a coordinator obj
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)  // pass self to coordinator
    }
}


// is nsobj class, confirm protocals
class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker

    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    // when select an image
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any] )
    {
        print("Image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // get the picked image and pass to the main thread
            DispatchQueue.main.async{
                self.parent.selectedImage = image
            }
        }
        
        // Dismiss the picker
        parent.isPickerShowing = false
    }
    // when cancel select
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled selected")
        
        // Dismiss the picker
        parent.isPickerShowing = false
    }
}
