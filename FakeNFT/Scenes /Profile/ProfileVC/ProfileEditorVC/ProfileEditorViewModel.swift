//
//  ProfileEditorViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class ProfileEditorViewModel {
    var userProfile: UserProfileModel? {
        didSet {
            saveProfileData()
        }
    }
    
    init(profile: UserProfileModel?) {
        self.userProfile = profile
    }
    
    func updateUserName(_ name: String) {
        guard let profile = userProfile else { return }
        userProfile = profile.updateUserName(name)
        saveProfileData()
    }
    
    func updateUserDescription(_ description: String) {
        guard let profile = userProfile else { return }
        userProfile = profile.updateUserDescription(description)
        saveProfileData()
    }
    
    func updateUserWebsite(_ website: String) {
        guard let profile = userProfile else { return }
        userProfile = profile.updateUserWebsite(website)
        saveProfileData()
    }
    
    private func saveProfileData() {
        guard let profile = userProfile else { return }
        let defaults = UserDefaults.standard
        defaults.set(profile.userName, forKey: "userName")
        defaults.set(profile.userDescription, forKey: "userDescription")
        defaults.set(profile.userWebsite, forKey: "userWebsite")
        // Сохранение других данных
    }
    
    static func loadProfileData() -> UserProfileModel? {
        let defaults = UserDefaults.standard
        guard
            let userName = defaults.string(forKey: "userName"),
            let userDescription = defaults.string(forKey: "userDescription"),
            let userWebsite = defaults.string(forKey: "userWebsite"),
            let userPhoto = defaults.string(forKey: "userPhoto")
        else {
            return nil
        }
        return UserProfileModel(
            userName: userName,
            userDescription: userDescription,
            userWebsite: userWebsite,
            userPhoto: userPhoto,
            myNftCount: defaults.array(forKey: "myNftCount") as? [String] ?? [],
            favoriteNftCount: defaults.array(forKey: "favoriteNftCount") as? [String] ?? []
        )
    }
}

