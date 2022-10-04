//
//  UserCellViewModel.swift
//  Instagram
//
//  Created by Andrey Kryukov on 04.10.2022.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImage: URL? {
        return URL(string: user.profileImage)
    }
    
    var userName: String {
        return user.userName
    }
    
    var fullName: String {
        return user.fullName
    }
    
    init(user: User) {
        self.user = user
    }
}
