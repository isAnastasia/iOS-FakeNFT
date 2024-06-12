//
//  ProfileInfoRequest.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct GetProfileInfoRequest: NetworkRequest {
    var httpBody: String?
    
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod {
        .get
    }
}
