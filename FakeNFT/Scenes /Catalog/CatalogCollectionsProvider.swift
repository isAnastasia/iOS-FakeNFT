//
//  CatalogCollectionsProvider.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation

typealias NftCollectionCompletion = (Result<[NftCollection], Error>) -> Void

final class CatalogCollectionsProvider {
    private let networkClient: NetworkClient
        
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
        
    func getCollections(completion: @escaping NftCollectionCompletion) {
        let request = NFTCollectionRequest()
        networkClient.send(request: request, type: [NftCollection].self) { [weak self] result in
            switch result {
            case .success(let nft):
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
