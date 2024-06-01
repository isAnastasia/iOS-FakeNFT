//
//  FavouriteNFTViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

final class FavouriteNFTViewModel: FavouriteNFTViewModelProtocol {
    var nfts: [MyNFTModel] = [] {
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
            MyNFTModel(
                images: ["liloNFT"],
                name: "Lilo",
                rating: 2,
                price: 1.78,
                id: "1",
                description: "от John Doe"
            ),
            MyNFTModel(
                images: ["springNFT"],
                name: "Spring",
                rating: 3,
                price: 1.78,
                id: "2",
                description: "от John Doe"
            ),
            MyNFTModel(
                images: ["aprilNFT"],
                name: "April",
                rating: 4,
                price: 1.78,
                id: "3",
                description: "от John Doe"
            )
        ]
    }
    
    func getNFT(at index: Int) -> MyNFTModel? {
        guard index >= 0 && index < nfts.count else { return nil }
        return nfts[index]
    }
    
    func numberOfNFTs() -> Int {
        return nfts.count
    }
}
