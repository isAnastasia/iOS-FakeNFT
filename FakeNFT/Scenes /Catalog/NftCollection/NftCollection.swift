//
//  NftCollection.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import Foundation

struct NftCollection {
    let id: String
    let title: String
    let cover: String
    let author: String
    let description: String
    let nfts: [String]
    
    init(id: String, title: String, cover: String, author: String, description: String, nfts: [String]) {
        self.id = id
        self.title = title
        self.cover = cover
        self.author = author
        self.description = description
        self.nfts = nfts
    }
}
