//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

struct UserProfileModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case name
        case avatar
        case description
        case website
        case nfts
        case likes
        case id
    }

    func updateUserName(_ name: String) -> UserProfileModel {
        return UserProfileModel(
            name: name,
            avatar: self.avatar,
            description: self.description,
            website: self.website,
            nfts: self.nfts,
            likes: self.likes,
            id: self.id
        )
    }

    func updateUserDescription(_ description: String) -> UserProfileModel {
        return UserProfileModel(
            name: self.name,
            avatar: self.avatar,
            description: description,
            website: self.website,
            nfts: self.nfts,
            likes: self.likes,
            id: self.id
        )
    }

    func updateUserWebsite(_ website: String) -> UserProfileModel {
        return UserProfileModel(
            name: self.name,
            avatar: self.avatar,
            description: self.description,
            website: website,
            nfts: self.nfts,
            likes: self.likes,
            id: self.id
        )
    }

    func updateMyNftCount(_ count: [String]) -> UserProfileModel {
        return UserProfileModel(
            name: self.name,
            avatar: self.avatar,
            description: self.description,
            website: self.website,
            nfts: count,
            likes: self.likes,
            id: self.id
        )
    }

    func updateFavoriteNftCount(_ count: [String]) -> UserProfileModel {
        return UserProfileModel(
            name: self.name,
            avatar: self.avatar,
            description: self.description,
            website: self.website,
            nfts: self.nfts,
            likes: count,
            id: self.id
        )
    }
}
