//
//  User.swift
//  Instagram
//
//  Created by Andrey Kryukov on 03.10.2022.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullName: String
    let profileImage: String
    let userName: String
    let uid: String
    
    var isFollowed = false
    
    var stats: UserStats!
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0)
    }
}

struct UserStats {
    var followers: Int
    var following: Int
//    var posts: Int
}
