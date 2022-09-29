//
//  AuthService.swift
//  Instagram
//
//  Created by Andrey Kryukov on 29.09.2022.
//

import UIKit
import Firebase

struct AuthCretentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCretential cretential: AuthCretentials) {
        print("cretential - \(cretential)")
    }
}
