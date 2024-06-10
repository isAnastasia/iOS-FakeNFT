//
//  CatalogCollectionViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

final class CatalogSingleCollectionViewModel {
    let collection: NftCollection
    var titleBinding: Binding<String>? {
        didSet {
            titleBinding?(convertCollectionName())
        }
    }
    var coverBinding: Binding<String>? {
        didSet {
            coverBinding?(collection.cover)
        }
    }
    
    init(collection: NftCollection) {
        self.collection = collection
    }
    
    private func convertCollectionName() -> String {
        let result = collection.title + " (" + String(collection.nfts.count) + ")"
        return result
    }
}
