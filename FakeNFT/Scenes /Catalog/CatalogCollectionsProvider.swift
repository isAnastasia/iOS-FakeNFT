//
//  CatalogCollectionsProvider.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation
import UIKit

final class CatalogCollectionsProvider {
    func getCollections() -> [CatalogSingleCollectionViewModel] {
        return [CatalogSingleCollectionViewModel(title: "Peach (11)", cover: UIImage(named: "cover.png")!)]
    }
}
