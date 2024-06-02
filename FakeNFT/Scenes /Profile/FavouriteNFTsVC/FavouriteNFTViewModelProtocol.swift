//
//  FavouriteNFTViewModelProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

import UIKit

protocol FavouriteNFTViewModelProtocol {
    var nfts: [MyNFTModel1] { get set }
    var onNFTsUpdated: (() -> Void)? { get set }
    
    func loadMockData()
    func getNFT(at index: Int) -> MyNFTModel1?
    func numberOfNFTs() -> Int
}
