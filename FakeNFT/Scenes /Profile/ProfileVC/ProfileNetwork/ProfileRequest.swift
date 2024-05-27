//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 26.5.2024.
//

import Foundation

struct ProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod { .get }
}


