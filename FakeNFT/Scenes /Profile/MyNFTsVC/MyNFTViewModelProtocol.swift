//
//  MyNFTViewModelProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

import UIKit

protocol MyNFTViewModelProtocol {
    var nfts: [MyNFTModel] { get set }
    var onNFTsUpdated: (() -> Void)? { get set }
    var onLoadingStatusChanged: ((Bool) -> Void)? { get set }
    
    func loadNFTs()
    func getNFT(at index: Int) -> MyNFTModel?
    func numberOfNFTs() -> Int
    
    func sortByPrice()
    func sortByRating()
    func sortByName()
    
    func getSortActions() -> [SortAction]
}
