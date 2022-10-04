//
//  UserService.swift
//  Instagram
//
//  Created by Andrey Kryukov on 03.10.2022.
//

import Firebase

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
}

