//
//  NftProvider.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation

typealias NftResultCompletion = (Result<NftResultModel, Error>) -> Void
typealias CartResultCompletion = (Result<CartResultModel, Error>) -> Void
typealias ProfileInfoResultCompletion = (Result<ProfileInfoResultModel, Error>) -> Void
typealias LikesResultCompletion = (Result<LikesResultModel, Error>) -> Void

struct LikesResultModel: Decodable {
    let likes: [String]
    let id: String
}

struct ChangeCartRequest: NetworkRequest {
    
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod {
        .put
    }
    var httpBody: String?
    
    init(httpBody: String) {
        self.httpBody = httpBody
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
    
    func getProfileInfo(completion: @escaping ProfileInfoResultCompletion) {
        let request = GetProfileInfoRequest()
        networkClient.send(request: request, type: ProfileInfoResultModel.self) { [weak self] result in
            switch result {
            case .success(let likes):
                completion(.success(likes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func changeLikes(likeId: String, completion: @escaping LikesResultCompletion) {
        getProfileInfo { [weak self] result in
            switch result {
            case .success(let userInfo):
                let oldLikes = userInfo.likes
                var newLikes: [String] = []
                if oldLikes.contains(likeId) {
                    newLikes = oldLikes.filter(){$0 != likeId}
                } else {
                    newLikes = oldLikes
                    newLikes.append(likeId)
                }
                let convertedLikes = newLikes.isEmpty ? "null" : newLikes.joined(separator: ",")
                let request = ChangeLikesRequest(httpBody: "likes=\(convertedLikes)")
                print(convertedLikes)
                
                self?.networkClient.send(request: request, type: LikesResultModel.self) { [weak self] result in
                    switch result {
                    case .success(let likes):
                        completion(.success(likes))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func changeCartInfo(nftId: String, completion: @escaping CartResultCompletion) {
        getMyCart { [weak self] result in
            switch result {
            case .success(let cart):
                print(cart)
                let oldCart = cart.nfts
                var newCart: [String] = []
                if oldCart.contains(nftId) {
                    newCart = oldCart.filter(){$0 != nftId}
                } else {
                    newCart = oldCart
                    newCart.append(nftId)
                }
                let convertedCart = newCart.isEmpty ? "null" : newCart.joined(separator: ",")
                let request = ChangeCartRequest(httpBody: "nfts=\(convertedCart)")
                print(convertedCart)
                
                self?.networkClient.send(request: request, type: CartResultModel.self) { [weak self] result in
                    switch result {
                    case .success(let cart):
                        completion(.success(cart))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
