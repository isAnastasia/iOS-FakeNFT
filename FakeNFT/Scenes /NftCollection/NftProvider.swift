//
//  NftProvider.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation

typealias NftResultCompletion = (Result<NftResultModel, Error>) -> Void
typealias CartResultCompletion = (Result<CartResultModel, Error>) -> Void
typealias FavouritesResultCompletion = (Result<FavouritesResultModel, Error>) -> Void

struct NftResultModel: Decodable {
    let id: String
    let name: String
    let images: [String]
    let rating: Int
    let price: Double
}

struct CartResultModel: Decodable {
    let nfts: [String]
    let id: String
}

struct FavouritesResultModel: Decodable {
    let likes: [String]
    let id: String
}

struct CartRequest: NetworkRequest {
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod {
        .get
    }
}

struct FavouritesRequest: NetworkRequest {
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod {
        .get
    }
}

final class NftProvider {
    private let networkClient: NetworkClient
        
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
        
    func getNftById(id: String, completion: @escaping NftResultCompletion) {
        let request = NFTRequest(id: id)
        networkClient.send(request: request, type: NftResultModel.self) { [weak self] result in
            switch result {
            case .success(let nft):
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMyCart(completion: @escaping CartResultCompletion) {
        let request = CartRequest()
        networkClient.send(request: request, type: CartResultModel.self) { [weak self] result in
            switch result {
            case .success(let cart):
                completion(.success(cart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMyFavourites(completion: @escaping FavouritesResultCompletion) {
        let request = FavouritesRequest()
        networkClient.send(request: request, type: FavouritesResultModel.self) { [weak self] result in
            switch result {
            case .success(let likes):
                completion(.success(likes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
