//
//  NftCollection.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 28.05.2024.
//

import Foundation

struct NftCollection: Decodable {
    let id: String
    let nfts: [String]
    let name: String
    let cover: String
}
