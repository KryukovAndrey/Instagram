//
//  ProfileHeaderViewModel.swift
//  Instagram
//
//  Created by Andrey Kryukov on 03.10.2022.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullName: String {
        return user.fullName
    }
    
    var profileImage: String {
        return user.profileImage
    }
    
    init(user: User) {
        self.user = user
    }
}
