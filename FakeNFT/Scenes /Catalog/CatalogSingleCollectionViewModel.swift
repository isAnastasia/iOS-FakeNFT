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
    let title: String
    let cover: UIImage
    
    var titleBinding: Binding<String>? {
        didSet {
            titleBinding?(title)
        }
    }
    var coverBinding: Binding<UIImage>? {
        didSet {
            coverBinding?(cover)
        }
    }
    
    init(title: String, cover: UIImage) {
        self.title = title
        self.cover = cover
    }
}
