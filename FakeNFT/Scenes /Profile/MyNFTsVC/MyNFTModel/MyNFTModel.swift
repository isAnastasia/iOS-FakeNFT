//
//  MyNFTModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 26.5.2024.
//

import UIKit

struct MyNFTModel: Codable, Equatable {
    let id: String
    let name: String
    let description: String
    let images: [String]
    let rating: Int
    let price: Double
    let author: String
    var authorName: String {
            return URL(string: author)?.host ?? "от John Doe"
        }
    
    func formattedPrice() -> String {
        return String(format: "%.2f ETH", price).replacingOccurrences(of: ".", with: ",")
    }
}
