//
//  NftProvider.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation

typealias NftResultCompletion = (Result<NftResultModel, Error>) -> Void

struct NftResultModel: Decodable {
    let id: String
    let name: String
    let images: [String]
    let rating: Int
    let price: Double
}

final class NftProvider {
    private let networkClient: NetworkClient
        
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
        
    func getNftById(id: String, completion: @escaping NftResultCompletion) {
        print("in provider")
        let request = NFTRequest(id: id)
        networkClient.send(request: request, type: NftResultModel.self) { [weak self] result in
            print("provider after send")
            switch result {
            case .success(let nft):
                print("success nft provider")
                completion(.success(nft))
            case .failure(let error):
                print("failure nft provider")
                completion(.failure(error))
            }
        }
    }
}
