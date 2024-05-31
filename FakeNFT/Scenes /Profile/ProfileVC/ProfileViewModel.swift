//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

final class ProfileViewModel {
    
    // MARK: - Public Properties
    var userProfile: UserProfileModel? {
        didSet {
            updateProfileData()
        }
    }
    
    var onProfileDataUpdated: (() -> Void)?
    var onLoadingStatusChanged: ((Bool) -> Void)?
    private let profileNetworkService: ProfileNetworkService
    
    // MARK: - Initializers
    init(profileNetworkService: ProfileNetworkService = ProfileNetworkService()) {
        self.profileNetworkService = profileNetworkService
        loadData()
    }
    
    // MARK: - Public Methods
    func loadData() {
        onLoadingStatusChanged?(true)
        
        profileNetworkService.fetchProfile { [weak self] result in
            self?.onLoadingStatusChanged?(false)
            switch result {
            case .success(let profile):
                self?.userProfile = profile
            case .failure(let error):
                print("Failed to load profile: \(error)")
            }
        }
    }
    
    func updateMyNftCount(_ count: [String]) {
        if let profile = userProfile {
            userProfile = profile.updateMyNftCount(count)
        }
    }
    
    func updateFavoriteNftCount(_ count: [String]) {
        if let profile = userProfile {
            userProfile = profile.updateFavoriteNftCount(count)
        }
    }
    
    func saveProfileData(completion: @escaping (Result<UserProfileModel, Error>) -> Void) {
        guard let profile = userProfile else { return }
        
        var encodedLikes = profile.likes.map { String($0) }.joined(separator: ",")
        if encodedLikes.isEmpty {
            encodedLikes = "null"
        }
        
        let profileData = "name=\(profile.name)&description=\(profile.description)&website=\(profile.website)&avatar=\(profile.avatar)&likes=\(encodedLikes)"
        
        profileNetworkService.updateProfile(profileData: profileData) { result in
            switch result {
            case .success(let updatedProfile):
                self.userProfile = updatedProfile
                completion(.success(updatedProfile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Properties
    private func updateProfileData() {
        onProfileDataUpdated?()
    }
}
