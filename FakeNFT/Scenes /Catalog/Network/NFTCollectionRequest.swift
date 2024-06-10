//
//  NFTCollectionRequest.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 28.05.2024.
//

import Foundation

struct NFTCollectionRequest: NetworkRequest {
    var httpBody: String?
    
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/collections")
    }
    var httpMethod: HttpMethod {
        .get
    }
}
