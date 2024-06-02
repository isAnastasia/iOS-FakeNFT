//
//  FavouriteNFTViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

struct MyNFTModel1: Codable, Equatable {
//    let createdAt: String
    let images: [String]
    let name: String
    let rating: Int
    let price: Double
    let id: String
    let description: String

    func formattedPrice() -> String {
        return String(format: "%.2f ETH", price).replacingOccurrences(of: ".", with: ",")
    }
}

final class FavouriteNFTViewModel: FavouriteNFTViewModelProtocol {
    
    var nfts: [MyNFTModel1] = [] {
        didSet {
            onNFTsUpdated?()
        }
    }
    
    var onNFTsUpdated: (() -> Void)?
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        nfts = [
            MyNFTModel1(
                images: ["liloNFT"],
                name: "Lilo",
                rating: 2,
                price: 1.78,
                id: "1",
                description: "от John Doe"
            ),
            MyNFTModel1(
                images: ["springNFT"],
                name: "Spring",
                rating: 3,
                price: 1.78,
                id: "2",
                description: "от John Doe"
            ),
            MyNFTModel1(
                images: ["aprilNFT"],
                name: "April",
                rating: 4,
                price: 1.78,
                id: "3",
                description: "от John Doe"
            )
        ]
    }
    
    func getNFT(at index: Int) -> MyNFTModel1? {
        guard index >= 0 && index < nfts.count else { return nil }
        return nfts[index]
    }
    
    func numberOfNFTs() -> Int {
        return nfts.count
    }
}
