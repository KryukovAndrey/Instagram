//
//  Post.swift
//  Instagram
//
//  Created by Andrey Kryukov on 11.10.2022.
//

import Firebase

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timesamp: Timestamp
    let postId: String
    let ownerImageUrl: String
    let ownerUserName: String
    var didLike = false

    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timesamp = dictionary["timesamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUserName = dictionary["ownerUserName"] as? String ?? ""
    }
}
