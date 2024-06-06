//
//  CartResultModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct CartResultModel: Decodable {
    let nfts: [String]
    let id: String
}
