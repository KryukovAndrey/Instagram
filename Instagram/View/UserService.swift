//
//  UserService.swift
//  Instagram
//
//  Created by Andrey Kryukov on 03.10.2022.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    static func fecthUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fecthUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({User(dictionary: $0.data())})

            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unFollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }

    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapShot, _) in
            let followers = snapShot?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapShot, _) in
                let following = snapShot?.documents.count ?? 0
                
                completion(UserStats(followers: followers, following: following))
            }
        }
    }
}

