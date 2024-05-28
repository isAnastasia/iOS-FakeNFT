//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation
import ProgressHUD
import UIKit

final class CatalogCollectionsViewModel {
    var collectionsBinding: Binding<[CatalogSingleCollectionViewModel]>?
    var errorBinding: (() -> ())?
    var showLoadingHandler: (() -> ())?
    var hideLoadingHandler: (() -> ())?

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
        //self.fetchCollections()
    }
    
    func filterCollectionsByName() {
        if !collections.isEmpty {
            var filteredCollections = collections
            filteredCollections.sort {
                $0.name < $1.name
            }
            collections = filteredCollections
        }
    }
    
    func filterCollectionsByCount() {
        if !collections.isEmpty {
            var filteredCollections = collections
            filteredCollections.sort {
                $0.nftCount > $1.nftCount
            }
            collections = filteredCollections
        }
    }
    
    func fetchCollections() {
        var convertedCollections: [CatalogSingleCollectionViewModel] = []
        showLoadingHandler?()
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
                self?.hideLoadingHandler?()
            case .failure(let error):
                guard let self = self else {
                    return
                }
                self.hideLoadingHandler?()
                self.errorBinding?()
                print(error)
            }
        }
    }
}
