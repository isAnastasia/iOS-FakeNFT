//
//  ChangeProfileInfoRequest.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 07.06.2024.
//

import Foundation

struct ChangeLikesRequest: NetworkRequest {
    
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod {
        .put
    }
    var httpBody: String?
    
    init(httpBody: String) {
        self.httpBody = httpBody
    }
}
