//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation

final class CatalogCollectionsViewModel {
    var collectionsBinding: Binding<[CatalogSingleCollectionViewModel]>?

    private(set) var collections: [CatalogSingleCollectionViewModel] = []{
        didSet {
            collectionsBinding?(collections)
        }
    }
    
    private let provider: CatalogCollectionsProvider
    
    init(provider: CatalogCollectionsProvider) {
        self.provider = provider
        self.collections = provider.getCollections()
    }
    
    convenience init() {
        let provider = CatalogCollectionsProvider()
        self.init(provider: provider)
    }
    
}
