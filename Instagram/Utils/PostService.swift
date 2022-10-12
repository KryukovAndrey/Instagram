//
//  PostService.swift
//  Instagram
//
//  Created by Andrey Kryukov on 10.10.2022.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, user: User, copletion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.imageUploader(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUserName": user.userName,
                        "ownerImageUrl": user.profileImage,
                        "ownerUid": uid] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: copletion)
        }
    }
    
    static func fetchPosts(copletion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            copletion(posts)
        }
    }
    
    static func fetchPosts(forUser uid: String, copletion: @escaping([Post]) -> Void) {
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
            
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            posts.sort { (post1, post2) -> Bool in
                return post1.timesamp.seconds > post2.timesamp.seconds
            }
            
            copletion(posts)
        }
    }
}
