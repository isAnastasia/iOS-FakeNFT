//
//  FavouriteNFTRequest.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 2.6.2024.
//

import Foundation

struct FavouriteNFTRequest: NetworkRequest {
    var dto: Encodable?
    
    var httpBody: String?
    
    var endpoint: URL? {
        URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod { .get }
}
