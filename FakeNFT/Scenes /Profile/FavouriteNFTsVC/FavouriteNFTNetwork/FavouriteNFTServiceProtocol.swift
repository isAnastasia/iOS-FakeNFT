//
//  FavouriteNFTServiceProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 2.6.2024.
//

import Foundation

protocol FavouriteNFTServiceProtocol {
    func fetchFavouriteNFTs(completion: @escaping (Result<[MyNFTModel], Error>) -> Void)
}
