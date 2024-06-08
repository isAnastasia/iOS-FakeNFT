//
//  NftCollectionCellViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 08.06.2024.
//

import Foundation

final class NftCollectionCellViewModel {
    var isLiked: Bool {
        didSet {
            isLikedBinding?(isLiked)
        }
    }
    var isInCart: Bool {
        didSet {
            isInCartBinding?(isInCart)
        }
    }
    var showLoadingHandler: (() -> ())?
    var showSuccessHandler: (() -> ())?
    var showErrorHandler: (() -> ())?
    var isLikedBinding: Binding<Bool>?
    var isInCartBinding: Binding<Bool>?
    var nftInfoBinding: Binding<NftCellModel>? {
        didSet {
            nftInfoBinding?(nftModel)
        }
    }
    var nftModel: NftCellModel
    
    init(nftModel: NftCellModel) {
        self.nftModel = nftModel
        self.isLiked = nftModel.isLiked
        self.isInCart = nftModel.isInCart
    }
    
    private let provider: NftProvider = NftProvider(networkClient: DefaultNetworkClient())
    
    func didLikeButtonTapped() {
        showLoadingHandler?()
        provider.changeLikes(likeId: nftModel.id) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let likes):
                    self.showSuccessHandler?()
                    if likes.likes.contains(self.nftModel.id) {
                        self.isLiked = true
                    } else {
                        self.isLiked = false
                    }
                case .failure(let error):
                    self.showErrorHandler?()
                    print(error)
                }
            }
        }
    }
    
    func didCartButtonTapped() {
        showLoadingHandler?()
        provider.changeCartInfo(nftId: nftModel.id) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                //
                switch result {
                case .success(let cart):
                    self.showSuccessHandler?()
                    if cart.nfts.contains(self.nftModel.id) {
                        self.isInCart = true
                    } else {
                        self.isInCart = false
                    }
                case .failure(let error):
                    self.showErrorHandler?()
                    print(error)
                }
            }
        }
    }
}
