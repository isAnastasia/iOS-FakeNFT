//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation

final class CatalogCollectionsViewModel {
    var collectionsBinding: Binding<[CatalogSingleCollectionViewModel]>?
    var errorBinding: (() -> ())?
    var showLoadingHandler: (() -> ())?
    var hideLoadingHandler: (() -> ())?
    
    var selectedSorting: SortingTypes {
        get {
            if let value = userDefaults.string(forKey: "sorting") {
                guard let sorting = SortingTypes(rawValue: value) else {
                    return SortingTypes.Default
                }
                return sorting
            } else {
                return SortingTypes.Default
            }
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: "sorting")
        }
    }

    private(set) var collections: [CatalogSingleCollectionViewModel] = []{
        didSet {
            collectionsBinding?(collections)
        }
    }
    
    private let provider: CatalogCollectionsProvider
    private let userDefaults = UserDefaults.standard
    
    convenience init() {
        let provider = CatalogCollectionsProvider(networkClient: DefaultNetworkClient())
        self.init(provider: provider)
    }
    
    init(provider: CatalogCollectionsProvider) {
        self.provider = provider
    }
    
    func sortingChanged(newSorting: SortingTypes) {
        selectedSorting = newSorting
        collections = sortCollections(collectionsToSort: collections)
    }
    
    func fetchCollections() {
        var convertedCollections: [CatalogSingleCollectionViewModel] = []
        showLoadingHandler?()
        provider.getCollections { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let nftCollectionsResult):
                nftCollectionsResult.forEach { collection in
                    convertedCollections.append(CatalogSingleCollectionViewModel(
                        title: collection.name,
                        cover: collection.cover,
                        nftCount: collection.nfts.count))
                }
                self.collections = self.sortCollections(collectionsToSort: convertedCollections)
                self.hideLoadingHandler?()
            case .failure(let error):
                self.hideLoadingHandler?()
                self.errorBinding?()
                print(error)
            }
        }
    }
    
    private func sortCollections(collectionsToSort: [CatalogSingleCollectionViewModel]) -> [CatalogSingleCollectionViewModel] {
        var sortedCollections: [CatalogSingleCollectionViewModel] = collectionsToSort
        switch selectedSorting {
        case .ByName:
            sortedCollections.sort {
                $0.name < $1.name
            }
            return sortedCollections
        case .ByNftCount:
            sortedCollections.sort {
                $0.nftCount > $1.nftCount
            }
            return sortedCollections
        case .Default:
            return sortedCollections
        }
    }
}
