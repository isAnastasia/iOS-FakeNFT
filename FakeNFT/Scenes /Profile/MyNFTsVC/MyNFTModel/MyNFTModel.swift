//
//  MyNFTModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 26.5.2024.
//

import UIKit

struct MyNFTModel: Codable, Equatable {
    let images: [String]
    let name: String
    let rating: Int
    let price: Double
    let id: String
    let description: String
}

