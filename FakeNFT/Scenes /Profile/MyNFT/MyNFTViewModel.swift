//
//  MyNFTViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class MyNFTViewModel {
    
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
                myNFTImages: ["liloNFT"],
                myNFTName: "Lilo",
                myNFTRating: 2,
                myNFTPrice: Double(String("1,78").replacingOccurrences(of: ",", with: ".")) ?? 0,
                myNFTID: "1",
                myNFTAuthor: "от John Doe"
            ),
            MyNFTModel(
                myNFTImages: ["springNFT"],
                myNFTName: "Spring",
                myNFTRating: 3,
                myNFTPrice: Double(String("1,78").replacingOccurrences(of: ",", with: ".")) ?? 0,
                myNFTID: "2",
                myNFTAuthor: "от John Doe"
            ),
            MyNFTModel(
                myNFTImages: ["aprilNFT"],
                myNFTName: "April",
                myNFTRating: 4,
                myNFTPrice: Double(String("1,78").replacingOccurrences(of: ",", with: ".")) ?? 0,
                myNFTID: "3",
                myNFTAuthor: "от John Doe"
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

