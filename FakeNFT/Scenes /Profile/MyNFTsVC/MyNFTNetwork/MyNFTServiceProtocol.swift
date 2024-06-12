//
//  MyNFTServiceProtocol.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 1.6.2024.
//

import Foundation

protocol MyNFTServiceProtocol {
    func fetchNFTs(completion: @escaping (Result<[MyNFTModel], Error>) -> Void)
}

