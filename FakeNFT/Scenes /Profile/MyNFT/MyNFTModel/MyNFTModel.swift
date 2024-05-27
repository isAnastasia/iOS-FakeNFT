//
//  MyNFTModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 26.5.2024.
//

import UIKit

struct MyNFTModel: Codable, Equatable {
    let myNFTImages: [String]
    let myNFTName: String
    let myNFTRating: Int
    let myNFTPrice: Double
    let myNFTID: String
    let myNFTAuthor: String
}

