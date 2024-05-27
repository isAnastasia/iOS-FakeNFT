//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class ProfileViewModel {
    var userProfile: UserProfileModel? {
        didSet {
            updateProfileData()
        }
    }
    
    var onProfileDataUpdated: (() -> Void)?
    
    init() {
        loadData()
    }
    
    func loadData() {
        let networkClient = DefaultNetworkClient()
        let request = ProfileRequest()
        
        networkClient.send(request: request, type: UserProfileModel.self) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.userProfile = profile
                print("Profile loaded successfully: \(profile)")
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
    
    private func updateProfileData() {
        onProfileDataUpdated?()
    }
}







//import UIKit
//
//class ProfileViewModel {
//    
//    // MARK: - Public Properties
//    var userProfile: UserProfileModel? {
//        didSet {
//            updateProfileData()
//        }
//    }
//    
//    var onProfileDataUpdated: (() -> Void)?
//    
//    // MARK: - Initializers
//    init() {
//        loadData()
//    }
//    
//    // MARK: - Public Methods
//    func loadData() {
//        if let savedProfile = ProfileEditorViewModel.loadProfileData() {
//            userProfile = savedProfile
//        } else {
//            userProfile = UserProfileModel(
//                userName: "Joaquin Phoenix",
//                userDescription: """
//                    Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.
//                    """,
//                userWebsite: "JoaquinPhoenix.com",
//                userPhoto: "userPhoto",
//                myNftCount: ["NFT1", "NFT2"],
//                favoriteNftCount: ["NFT1"]
//            )
//        }
//    }
//    
//    func updateMyNftCount(_ count: [String]) {
//        if let profile = userProfile {
//            userProfile = profile.updateMyNftCount(count)
//        }
//    }
//    
//    func updateFavoriteNftCount(_ count: [String]) {
//        if let profile = userProfile {
//            userProfile = profile.updateFavoriteNftCount(count)
//        }
//    }
//    
//    // MARK: - Private Methods
//    private func updateProfileData() {
//        onProfileDataUpdated?()
//    }
//}
