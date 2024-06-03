//
//  NftResultModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct NftResultModel: Decodable {
    let id: String
    let name: String
    let images: [String]
    let rating: Int
    let price: Double
}
