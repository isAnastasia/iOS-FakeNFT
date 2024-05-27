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
    
    convenience init() {
        let provider = CatalogCollectionsProvider(networkClient: DefaultNetworkClient())
        self.init(provider: provider)
    }
    
    init(provider: CatalogCollectionsProvider) {
        self.provider = provider
        self.fetchCollections()
    }
    
    func filterCollectionsByName() {
        
    }
    
    func filterCollectionsByCount() {
        
    }
    
    private func fetchCollections() {
        var convertedCollections: [CatalogSingleCollectionViewModel] = []
        provider.getCollections { [weak self] result in
            switch result {
            case .success(let nftCollectionsResult):
                nftCollectionsResult.forEach { collection in
                    convertedCollections.append(CatalogSingleCollectionViewModel(
                        title: collection.name,
                        cover: collection.cover,
                        nftCount: collection.nfts.count))
                }
                self?.collections = convertedCollections
            case .failure(let error):
                print(error)
            }
        }
    }
}
