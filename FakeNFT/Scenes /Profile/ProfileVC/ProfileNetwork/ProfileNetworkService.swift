//
//  ProfileNetworkService.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

import Foundation

final class ProfileNetworkService: ProfileNetworkServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchProfile(
        completion: @escaping (Result<UserProfileModel, Error>) -> Void
    ) {
        let request = ProfileRequest()
        networkClient.send(request: request, type: UserProfileModel.self) { result in
            completion(result)
        }
    }
    
    func updateProfile(
        profileData: String,
        completion: @escaping (Result<UserProfileModel, Error>) -> Void
    ) {
        let request = UpdateProfileRequest(profileData)
        networkClient.send(request: request, type: UserProfileModel.self) { result in
            completion(result)
        }
    }
}


