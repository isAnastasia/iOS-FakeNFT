//
//  ProfileNetworkServiceProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 1.6.2024.
//

import UIKit

protocol ProfileNetworkServiceProtocol {
    func fetchProfile(completion: @escaping (Result<UserProfileModel, Error>) -> Void)
    func updateProfile(profileData: String, completion: @escaping (Result<UserProfileModel, Error>) -> Void)
}
