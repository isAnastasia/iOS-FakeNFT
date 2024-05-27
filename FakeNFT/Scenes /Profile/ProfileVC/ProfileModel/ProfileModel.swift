//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

struct UserProfileModel {
    let userName: String
    let userDescription: String
    let userWebsite: String
    let userPhoto: String
    let myNftCount: [String]
    let favoriteNftCount: [String]
    
    func updateUserName(_ name: String) -> UserProfileModel {
        return UserProfileModel(
            userName: name,
            userDescription: self.userDescription,
            userWebsite: self.userWebsite,
            userPhoto: self.userPhoto,
            myNftCount: self.myNftCount,
            favoriteNftCount: self.favoriteNftCount
        )
    }
    
    func updateUserDescription(_ description: String) -> UserProfileModel {
        return UserProfileModel(
            userName: self.userName,
            userDescription: description,
            userWebsite: self.userWebsite,
            userPhoto: self.userPhoto,
            myNftCount: self.myNftCount,
            favoriteNftCount: self.favoriteNftCount
        )
    }
    
    func updateUserWebsite(_ website: String) -> UserProfileModel {
        return UserProfileModel(
            userName: self.userName,
            userDescription: self.userDescription,
            userWebsite: website,
            userPhoto: self.userPhoto,
            myNftCount: self.myNftCount,
            favoriteNftCount: self.favoriteNftCount
        )
    }
    
    func updateMyNftCount(_ count: [String]) -> UserProfileModel {
        return UserProfileModel(
            userName: self.userName,
            userDescription: self.userDescription,
            userWebsite: self.userWebsite,
            userPhoto: self.userPhoto,
            myNftCount: count,
            favoriteNftCount: self.favoriteNftCount
        )
    }
    
    func updateFavoriteNftCount(_ count: [String]) -> UserProfileModel {
        return UserProfileModel(
            userName: self.userName,
            userDescription: self.userDescription,
            userWebsite: self.userWebsite,
            userPhoto: self.userPhoto,
            myNftCount: self.myNftCount,
            favoriteNftCount: count
        )
    }
}
