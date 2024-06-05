//
//  ProfileEditorViewModelProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

import UIKit

protocol ProfileEditorViewModelProtocol {
    var userProfile: UserProfileModel { get }
    var onProfileUpdated: ((UserProfileModel) -> ())? { get set }
    
    func updateUserName(_ name: String)
    func updateUserDescription(_ description: String)
    func updateUserWebsite(_ website: String)
    func saveProfileData(completion: @escaping (Result<UserProfileModel, Error>) -> ())
    func updateAvatar(_ avatar: String)
}

