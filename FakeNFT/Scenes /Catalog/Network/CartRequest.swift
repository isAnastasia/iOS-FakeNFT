//
//  CartRequest.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct CartRequest: NetworkRequest {
    let baseUrl = NetworkConstants.baseURL
    var endpoint: URL? {
        URL(string: "\(baseUrl)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod {
        .get
    }
}
