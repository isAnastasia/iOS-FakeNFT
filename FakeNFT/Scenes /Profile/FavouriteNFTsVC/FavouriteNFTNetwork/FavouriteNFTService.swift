//
//  FavouriteNFTService.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 2.6.2024.
//

import Foundation

final class FavouriteNFTService: FavouriteNFTServiceProtocol {
    
    // MARK: - Private Properties
    private var userProfile: UserProfileModel?
    private let client: NetworkClient
    
    // MARK: - Initializers
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
        loadUserProfile()
    }
    
    // MARK: - Public Methods
    func fetchFavouriteNFTs(completion: @escaping (Result<[MyNFTModel], Error>) -> Void) {
        let request = ProfileRequest()
        client.send(request: request, type: UserProfileModel.self) { result in
            switch result {
            case .success(let profile):
                self.fetchNFTDetails(ids: profile.likes, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func unlikeNFT(nftID: String, completion: @escaping (Bool) -> Void) {
        guard let userProfile = userProfile else {
            completion(false)
            return
        }
        
        if let index = userProfile.likes.firstIndex(of: nftID) {
            var updatedLikes = userProfile.likes
            updatedLikes.remove(at: index)
            
            let updatedProfile = userProfile.updateFavoriteNftCount(updatedLikes)
            
            var encodedLikes = updatedProfile.likes.map { String($0) }.joined(separator: ",")
            if encodedLikes.isEmpty {
                encodedLikes = "null"
            }
            
            let profileData = "name=\(updatedProfile.name)&description=\(updatedProfile.description)&website=\(updatedProfile.website)&avatar=\(updatedProfile.avatar)&likes=\(encodedLikes)&nfts=\(updatedProfile.nfts.joined(separator: ","))"
            let request = UpdateProfileRequest(profileData)
            
            client.send(request: request, type: UserProfileModel.self) { result in
                switch result {
                case .success(let updatedProfile):
                    self.userProfile = updatedProfile
                    completion(true)
                case .failure(let error):
                    print("Failed to update profile: \(error)")
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    // MARK: - Private Methods
    private func loadUserProfile() {
        let request = ProfileRequest()
        client.send(request: request, type: UserProfileModel.self) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.userProfile = profile
            case .failure(let error):
                print("Failed to load user profile: \(error)")
            }
        }
    }
    
    private func fetchNFTDetails(ids: [String], completion: @escaping (Result<[MyNFTModel], Error>) -> Void) {
        var nftItems: [MyNFTModel] = []
        let dispatchGroup = DispatchGroup()
        
        for id in ids {
            dispatchGroup.enter()
            let request = GetNftByIdRequest(id: id)
            client.send(request: request, type: MyNFTModel.self) { result in
                switch result {
                case .success(let nft):
                    nftItems.append(nft)
                case .failure(let error):
                    completion(.failure(error))
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(nftItems))
        }
    }
}
