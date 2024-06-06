//
//  ProfileInfoRequest.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct ProfileInfoRequest: NetworkRequest {
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod {
        .get
    }
}
