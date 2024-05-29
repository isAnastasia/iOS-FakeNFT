//
//  ProfileEditorViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

final class ProfileEditorViewModel {
    
    // MARK: - Public Properties
    var userProfile: UserProfileModel?
    
    // MARK: - Initializers
    init(profile: UserProfileModel?) {
        self.userProfile = profile
    }
    
    // MARK: - Public Methods
    func updateUserName(_ name: String) {
        guard let profile = userProfile else { return }
        print("Updating user name to: \(name)")
        userProfile = profile.updateUserName(name)
    }
    
    func updateUserDescription(_ description: String) {
        guard let profile = userProfile else { return }
        print("Updating user description to: \(description)")
        userProfile = profile.updateUserDescription(description)
    }
    
    func updateUserWebsite(_ website: String) {
        guard let profile = userProfile else { return }
        print("Updating user website to: \(website)")
        userProfile = profile.updateUserWebsite(website)
    }
    
    func saveProfileData(completion: @escaping (Result<UserProfileModel, Error>) -> Void) {
        guard let profile = userProfile else { return }
        
        let networkClient = DefaultNetworkClient()
        
        var encodedLikes = profile.likes.map { String($0) }.joined(separator: ",")
        if encodedLikes.isEmpty {
            encodedLikes = "null"
        }
        let profileData = "name=\(profile.name)&description=\(profile.description)&website=\(profile.website)&avatar=\(profile.avatar)"
        
        let request = UpdateProfileRequest(profileData)
        
        print("Отправка запроса на сервер для сохранения профиля: \(profile)")
        
        networkClient.send(request: request, type: UserProfileModel.self) { result in
            switch result {
            case .success(let updatedProfile):
                self.userProfile = updatedProfile
                print("Профиль успешно обновлен на сервере: \(updatedProfile)")
                completion(.success(updatedProfile))
            case .failure(let error):
                if let httpResponse = error as? NetworkClientError,
                   case .httpStatusCode(let statusCode) = httpResponse {
                    print("HTTP Status Code: \(statusCode)")
                }
                print("Ошибка при сохранении профиля на сервере: \(error)")
                completion(.failure(error))
            }
        }
    }
}
