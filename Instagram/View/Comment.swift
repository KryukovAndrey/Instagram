//
//  Comment.swift
//  Instagram
//
//  Created by Andrey Kryukov on 12.10.2022.
//

import Firebase

struct Comment {
    let uid: String
    let userName: String
    let profileImageUrl: String
    let timesamp: Timestamp
    let commentText: String

    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timesamp = dictionary["timesamp"] as? Timestamp ?? Timestamp(date: Date())
        self.commentText = dictionary["comment"] as? String ?? ""
    }
}
