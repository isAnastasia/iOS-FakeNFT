//
//  FavouriteNFTViewModelProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

protocol FavouriteNFTViewModelProtocol {
    var nfts: [MyNFTModel] { get set }
    var onNFTsUpdated: (() -> Void)? { get set }
    var onLoadingStatusChanged: ((Bool) -> Void)? { get set }
    
    func loadFavouriteNFTs()
    func getNFT(at index: Int) -> MyNFTModel?
    func numberOfNFTs() -> Int
}
