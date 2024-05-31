//
//  CatalogCollectionViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

final class CatalogSingleCollectionViewModel {
    let name: String
    let cover: String
    let nftCount: Int
    
    var titleBinding: Binding<String>? {
        didSet {
            titleBinding?(convertCollectionName())
        }
    }
    var coverBinding: Binding<String>? {
        didSet {
            coverBinding?(cover)
        }
    }
    
    init(title: String, cover: String, nftCount: Int) {
        self.name = title
        self.cover = cover
        self.nftCount = nftCount
    }
    
    private func convertCollectionName() -> String {
        let result = name + " (" + String(nftCount) + ")"
        return result
    }
}
