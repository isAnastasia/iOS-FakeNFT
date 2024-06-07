//
//  NftModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation

struct NftCellModel {
    let cover: String
    let name: String
    let stars: Int
    var isLiked: Bool
    let price: Double
    var isInCart: Bool
    
    let id: String
    
    init(cover: String, name: String, stars: Int, isLiked: Bool, price: Double, isInCart: Bool, id: String) {
        self.cover = cover
        self.name = name
        self.stars = stars
        self.isLiked = isLiked
        self.price = price
        self.isInCart = isInCart
        self.id = id
    }
}
