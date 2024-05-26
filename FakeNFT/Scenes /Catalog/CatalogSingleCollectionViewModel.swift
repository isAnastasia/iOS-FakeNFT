//
//  CatalogCollectionViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 26.05.2024.
//

import Foundation
import UIKit

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
    var coverBinding: Binding<UIImage>? {
        didSet {
            coverBinding?(loadCover())
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
    
    private func loadCover() -> UIImage {
        return UIImage(named: "cover")!
    }
}
