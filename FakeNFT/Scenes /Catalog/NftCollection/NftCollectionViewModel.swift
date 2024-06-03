//
//  NftCollectionViewModel.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation

final class NftCollectionViewModel {
    let collectionInformation: NftCollection
    var nftsBinding: Binding<[NftCellModel]>?
    var showLoadingHandler: (() -> ())?
    var hideLoadingHandler: (() -> ())?
    var errorHandler: (() -> ())?
    var websiteLink = ""
    
    private(set) var nfts: [NftCellModel] = []{
        didSet {
            nftsBinding?(nfts)
        }
    }
    private var likedNfts: Set<String> = []
    private var nftsInCart: Set<String> = []
    private let provider: NftProvider
    
    init(collectionInfo: NftCollection) {
        self.collectionInformation = collectionInfo
        self.provider = NftProvider(networkClient: DefaultNetworkClient())
    }
    
    func fetchDataToDisplay() {
        fetchNfts { [weak self] result in
            switch result {
            case .success(let nfts):
                self?.nfts = nfts
            case .failure(let error):
                self?.hideLoadingHandler?()
                self?.errorHandler?()
            }
        }
    }
    
    func fetchNfts(completion: @escaping (Result<[NftCellModel], Error>) -> Void) {
        let group = DispatchGroup()
        var fetchedNfts: [NftResultModel] = []
        showLoadingHandler?()
        
        group.enter()
        provider.getMyCart { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let cart):
                self.nftsInCart = Set(cart.nfts)
                //group.leave()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            group.leave()
        }
        
        group.enter()
        provider.getMyFavourites { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let userInfo):
                self.likedNfts = Set(userInfo.likes)
                self.websiteLink = userInfo.website
                //group.leave()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            group.leave()
        }
        
        
        for id in collectionInformation.nfts {
            group.enter()
            provider.getNftById(id: id) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let nftResult):
                    fetchedNfts.append(nftResult)
                    //group.leave()
                case .failure(let error):
                    print(error)
                    //group.leave()
                    //self.hideLoadingHandler?()
                    completion(.failure(error))
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.hideLoadingHandler?()
            var allNfts = fetchedNfts.map {
                return NftCellModel(cover: $0.images.first!,
                                    name: $0.name,
                                    stars: $0.rating,
                                    isLiked: self.checkIfNftIsLiked(id: $0.id),
                                    price: $0.price,
                                    isInCart: self.checkIfNftIsInCart(id: $0.id))
            }
            completion(.success(allNfts))
            //self.nfts = allNfts
        }
    }
    
    private func checkIfNftIsLiked(id: String) -> Bool {
        if likedNfts.contains(id) {
            return true
        }
        return false
    }
    
    private func checkIfNftIsInCart(id: String) -> Bool {
        if nftsInCart.contains(id) {
            return true
        }
        return false
    }
}
