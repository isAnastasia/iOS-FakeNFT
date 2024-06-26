//
//  FavouriteNFTViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

final class FavouriteNFTViewModel: FavouriteNFTViewModelProtocol {
    
    // MARK: - Public Properties
    var nfts: [MyNFTModel] = [] {
        didSet {
            onNFTsUpdated?()
        }
    }
    
    var onNFTsUpdated: (() -> Void)?
    var onLoadingStatusChanged: ((Bool) -> Void)?
    
    // MARK: - Private Properties
    private let favouriteNFTService: FavouriteNFTServiceProtocol
    
    // MARK: - Initializers
    init(favouriteNFTService: FavouriteNFTService = FavouriteNFTService()) {
        self.favouriteNFTService = favouriteNFTService
        loadFavouriteNFTs()
    }
    
    // MARK: - Public Methods
    func loadFavouriteNFTs() {
        onLoadingStatusChanged?(true)
        favouriteNFTService.fetchFavouriteNFTs { [weak self] result in
            self?.onLoadingStatusChanged?(false)
            switch result {
            case .success(let nfts):
                self?.nfts = nfts
            case .failure(let error):
                print("Failed to load favourite NFTs: \(error)")
            }
        }
    }
    
    func getNFT(at index: Int) -> MyNFTModel? {
        guard index >= 0 && index < nfts.count else { return nil }
        return nfts[index]
    }
    
    func numberOfNFTs() -> Int {
        return nfts.count
    }

    func unlikeNFT(at index: Int) {
        guard index >= 0 && index < nfts.count else { return }
        let nft = nfts[index]
        favouriteNFTService.unlikeNFT(nftID: nft.id) { [weak self] success in
            if success {
                self?.nfts.remove(at: index)
            } else {
                print("Failed to unlike NFT with ID: \(nft.id)")
            }
        }
    }
}
