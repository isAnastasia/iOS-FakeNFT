//
//  ProfileEditorViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class ProfileEditorViewModel {
    var userProfile: UserProfile? {
        didSet {
            saveProfileData()
        }
    }
    
    init(profile: UserProfile?) {
        self.userProfile = profile
    }
    
    func updateUserName(_ name: String) {
        userProfile?.userName = name
        saveProfileData()
    }
    
    func updateUserDescription(_ description: String) {
        userProfile?.userDescription = description
        saveProfileData()
    }
    
    func updateUserWebsite(_ website: String) {
        userProfile?.userWebsite = website
        saveProfileData()
    }
    
    private func saveProfileData() {
        guard let profile = userProfile else { return }
        let defaults = UserDefaults.standard
        defaults.set(profile.userName, forKey: "userName")
        defaults.set(profile.userDescription, forKey: "userDescription")
        defaults.set(profile.userWebsite, forKey: "userWebsite")
    }
    
    static func loadProfileData() -> UserProfile? {
        let defaults = UserDefaults.standard
        guard
            let userName = defaults.string(forKey: "userName"),
            let userDescription = defaults.string(forKey: "userDescription"),
            let userWebsite = defaults.string(forKey: "userWebsite"),
            let userPhoto = UIImage(named: "userPhoto")
        else {
            return nil
        }
        return UserProfile(
            userName: userName,
            userDescription: userDescription,
            userWebsite: userWebsite,
            userPhoto: userPhoto,
            myNftCount: 112,
            favoriteNftCount: 11
        )
    }
}
