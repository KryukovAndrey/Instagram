//
//  ImageUploader.swift
//  Instagram
//
//  Created by Andrey Kryukov on 29.09.2022.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func imageUploader(image: UIImage, complection: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print("DEBUG: Failed to upload image - \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                complection(imageUrl)
            }
        }
    }
}
