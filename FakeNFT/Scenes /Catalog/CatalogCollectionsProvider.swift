//
//  CatalogCollectionsProvider.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation
import UIKit

struct NFTCollectionRequest: NetworkRequest {
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/collections")
    }
    var httpMethod: HttpMethod {
        .get
    }
}

struct NftCollection: Decodable {
    let id: String
    let nfts: [String]
    let name: String
    let cover: String
}

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
                print(nft)
                completion(.success(nft))
            case .failure(let error):
                print("ERRoR")
                completion(.failure(error))
            }
        }
    }
}
