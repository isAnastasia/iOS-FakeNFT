//
//  FavouriteNFTService.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 2.6.2024.
//

import UIKit

final class FavouriteNFTService: FavouriteNFTServiceProtocol {
    private let client: NetworkClient
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    func fetchFavouriteNFTs(completion: @escaping (Result<[MyNFTModel], Error>) -> Void) {
        let request = ProfileRequest()
        client.send(request: request, type: UserProfileModel.self) { result in
            switch result {
            case .success(let profile):
                let favouriteNFTIds = profile.likes
                self.fetchNFTDetails(ids: favouriteNFTIds, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchNFTDetails(
        ids: [String],
        completion: @escaping (Result<[MyNFTModel], Error>
        ) -> Void) {
        
        var nftItems: [MyNFTModel] = []
        let dispatchGroup = DispatchGroup()
        
        for id in ids {
            dispatchGroup.enter()
            let request = GetNftByIdRequest(id: id)
            client.send(request: request, type: MyNFTModel.self) { result in
                switch result {
                case .success(let nft):
                    nftItems.append(nft)
                    dispatchGroup.leave()
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(nftItems))
        }
    }
}
