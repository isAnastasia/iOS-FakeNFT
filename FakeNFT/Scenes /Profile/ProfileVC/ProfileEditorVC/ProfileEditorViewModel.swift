//
//  ProfileEditorViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

final class ProfileEditorViewModel: ProfileEditorViewModelProtocol {
    // MARK: - Public Properties
    var userProfile: UserProfileModel
    var onProfileUpdated: ((UserProfileModel) -> ())?
    private let profileNetworkService: ProfileNetworkService
    
    // MARK: - Initializers
    init(profile: UserProfileModel, profileNetworkService: ProfileNetworkService = ProfileNetworkService()) {
        self.userProfile = profile
        self.profileNetworkService = profileNetworkService
    }
    
    // MARK: - Public Methods
    func updateAvatar(_ avatar: String) {
        userProfile = userProfile.updateAvatar(avatar)
    }
    
    func updateUserName(_ name: String) {
        userProfile = userProfile.updateUserName(name)
    }
    
    func updateUserDescription(_ description: String) {
        userProfile = userProfile.updateUserDescription(description)
    }
    
    func updateUserWebsite(_ website: String) {
        userProfile = userProfile.updateUserWebsite(website)
    }
    
    func saveProfileData(completion: @escaping (Result<UserProfileModel, Error>) -> ()) {
        var encodedLikes = userProfile.likes.map { String($0) }.joined(separator: ",")
        if encodedLikes.isEmpty {
            encodedLikes = "null"
        }
        let profileData = "name=\(userProfile.name)&description=\(userProfile.description)&website=\(userProfile.website)&avatar=\(userProfile.avatar)"
        
        profileNetworkService.updateProfile(profileData: profileData) { [weak self] result in
            switch result {
            case .success(let updatedProfile):
                self?.userProfile = updatedProfile
                self?.onProfileUpdated?(updatedProfile)
                completion(.success(updatedProfile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
