//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class ProfileViewModel {
    
    // MARK: - Public Properties
    var userProfile: UserProfileModel? {
        didSet {
            updateProfileData()
        }
    }
    
    var onProfileDataUpdated: (() -> Void)?
    
    // MARK: - Initializers
    init() {
        loadData()
    }
    
    // MARK: - Public Methods
    func loadData() {
        if let savedProfile = ProfileEditorViewModel.loadProfileData() {
            userProfile = savedProfile
        } else {
            userProfile = UserProfileModel(
                userName: "Joaquin Phoenix",
                userDescription: """
                    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.
                    """,
                userWebsite: "JoaquinPhoenix.com",
                userPhoto: UIImage(named: "userPhoto") ?? UIImage(),
                myNftCount: 112,
                favoriteNftCount: 11
            )
        }
    }
    
    func updateMyNftCount(_ count: Int) {
        userProfile?.myNftCount = count
        updateProfileData()
    }
    
    func updateFavoriteNftCount(_ count: Int) {
        userProfile?.favoriteNftCount = count
        updateProfileData()
    }
    
    // MARK: - Private Methods
    private func updateProfileData() {
        onProfileDataUpdated?()
    }
}

