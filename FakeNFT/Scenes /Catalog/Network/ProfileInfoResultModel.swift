//
//  ProfileInfoResultModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct ProfileInfoResultModel: Decodable {
    let likes: [String]
    let website: String
    let id: String
}
