//
//  ProfileUpdateRequest.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 26.5.2024.
//

import Foundation

struct UpdateProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(NetworkConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable?
    
    var httpBody: String?

    init(_ httpBody: String) {
        self.httpBody = httpBody
    }
}




