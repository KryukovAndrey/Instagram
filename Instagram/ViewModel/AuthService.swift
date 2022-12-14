//
//  AuthService.swift
//  Instagram
//
//  Created by Andrey Kryukov on 29.09.2022.
//

import UIKit
import Firebase
import FirebaseAuth

struct AuthCretentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

struct AuthService {
    static func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCretential cretential: AuthCretentials, completion: @escaping(Error?) -> Void ) {
        
        ImageUploader.imageUploader(image: cretential.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: cretential.email, password: cretential.password) { (result, error) in
                
                if let error = error {
                    print("DEBUG: Failed to regiter user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String : Any] = ["email" : cretential.email,
                                            "fullName" : cretential.fullName,
                                            "profileImage" : imageUrl,
                                            "uid" : uid,
                                            "userName" : cretential.userName]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
    
    static func resetPassword(withEmail email: String, completion: ((Error?) -> Void)?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
