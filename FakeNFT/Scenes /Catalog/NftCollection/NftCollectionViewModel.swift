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
    var showSuccessHandler: (() -> ())?
    var showErrorHandler: (() -> ())?
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
    
    //MARK: - Public Methods
    func fetchDataToDisplay() {
        self.showLoadingHandler?()
        fetchData { [weak self] result in
            switch result {
            case .success(let nfts):
                self?.showSuccessHandler?()
                self?.nfts = nfts
            case .failure(_):
                self?.showErrorHandler?()
            }
        }
    }
    
    func didLikeButtonTapped(nftId: String, completion: @escaping (Bool) -> ()) {
        showLoadingHandler?()
        provider.changeLikes(likeId: nftId) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let likes):
                    self.showSuccessHandler?()
                    if likes.likes.contains(nftId) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    self.showErrorHandler?()
                    print(error)
                }
            }

        }
    }
    
    func didCartButtonTapped(nftId: String, completion: @escaping (Bool) -> ()) {
        showLoadingHandler?()
        provider.changeCartInfo(nftId: nftId) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                //
                switch result {
                case .success(let cart):
                    self.showSuccessHandler?()
                    if cart.nfts.contains(nftId) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    self.showErrorHandler?()
                    print(error)
                }
            }
        }
    }
    
    //MARK: - Private Methods
    private func fetchData(completion: @escaping (Result<[NftCellModel], Error>) -> Void) {
        provider.getMyCart { [weak self] result in
            switch result {
            case .success(let cart):
                self?.nftsInCart = Set(cart.nfts)
                self?.getMyLikes { [weak self] result in
                    switch result {
                    case .success(let userInfo):
                        self?.likedNfts = Set(userInfo.likes)
                        self?.websiteLink = userInfo.website
                        self?.getNfts { [weak self] result in
                            self?.handleResult(result: result, completion: completion)
                        }
                    case .failure(let error):
                        self?.handleResult(result: .failure(error), completion: completion)
                    }
                }
            case .failure(let error):
                self?.handleResult(result: .failure(error), completion: completion)
            }
        }
    }
    
    private func handleResult<T>(result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let succes):
                completion(.success(succes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getMyLikes(completion: @escaping ProfileInfoResultCompletion) {
        provider.getProfileInfo { [weak self] result in
            switch result {
            case .success(let userInfo):
                completion(.success(userInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getNfts(completion: @escaping (Result<[NftCellModel], Error>) -> Void) {
        let group = DispatchGroup()
        var fetchedNfts: [NftResultModel] = []
        
        for id in collectionInformation.nfts {
            group.enter()
            provider.getNftById(id: id) { [weak self] result in
                switch result {
                case .success(let nftResult):
                    fetchedNfts.append(nftResult)
                case .failure(let error):
                    completion(.failure(error))
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            let allNfts = fetchedNfts.map {
                return NftCellModel(cover: $0.images.first!,
                                    name: $0.name,
                                    stars: $0.rating,
                                    isLiked: self.checkIfNftIsLiked(id: $0.id),
                                    price: $0.price,
                                    isInCart: self.checkIfNftIsInCart(id: $0.id),
                                    id: $0.id)
            }
            completion(.success(allNfts))
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
