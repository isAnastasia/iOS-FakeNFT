//
//  ProfileNetworkService.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

import Foundation

final class ProfileNetworkService: ProfileNetworkServiceProtocol {
    
    // MARK: - Private Properties
    private let networkClient: NetworkClient
    
    // MARK: - Initializers
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public Properties
    func fetchProfile(
        completion: @escaping (Result<UserProfileModel, Error>) -> ()
    ) {
        let request = ProfileRequest()
        networkClient.send(request: request, type: UserProfileModel.self) { result in
            completion(result)
        }
    }
    
    func updateProfile(
        profileData: String,
        completion: @escaping (Result<UserProfileModel, Error>) -> ()
    ) {
        let request = UpdateProfileRequest(profileData)
        networkClient.send(request: request, type: UserProfileModel.self) { result in
            completion(result)
        }
    }
}


