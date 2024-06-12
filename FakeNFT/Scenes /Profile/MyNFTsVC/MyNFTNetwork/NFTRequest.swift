//
//  NFTRequest.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 1.6.2024.
//

import Foundation

struct GetNftByIdRequest: NetworkRequest {
    
    // MARK: - Public Properties
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
    var httpBody: String?
    var endpoint: URL? { URL(string: "\(NetworkConstants.baseURL)/api/v1/nft/\(id)") }
    
    // MARK: - Private Properties
    private let id: String
    
    // MARK: - Initializers
    init(id: String) {
        self.id = id
    }
}
