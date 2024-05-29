//
//  MyNFTViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

final class MyNFTViewModel {
    
    // MARK: - Public Properties
    var nfts: [MyNFTModel] = [] {
        didSet {
            onNFTsUpdated?()
        }
    }
    
    var onNFTsUpdated: (() -> Void)?
    
    // MARK: - Initializers
    init() {
        loadMockData()
    }
    
    // MARK: - Public Methods
    func loadMockData() {
        nfts = [
            MyNFTModel(
                images: ["liloNFT"],
                name: "Lilo",
                rating: 2,
                price: Double(String("1,78").replacingOccurrences(of: ",", with: ".")) ?? 0,
                id: "1",
                description: "от John Doe"
            ),
            MyNFTModel(
                images: ["springNFT"],
                name: "Spring",
                rating: 3,
                price: Double(String("1,78").replacingOccurrences(of: ",", with: ".")) ?? 0,
                id: "2",
                description: "от John Doe"
            ),
            MyNFTModel(
                images: ["aprilNFT"],
                name: "April",
                rating: 4,
                price: Double(String("1,78").replacingOccurrences(of: ",", with: ".")) ?? 0,
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
    
    // MARK: - Sorting Methods
    func sortByPrice() {
        nfts.sort { $0.price < $1.price }
    }
    
    func sortByRating() {
        nfts.sort { $0.rating > $1.rating }
    }
    
    func sortByName() {
        nfts.sort { $0.name < $1.name }
    }
}
