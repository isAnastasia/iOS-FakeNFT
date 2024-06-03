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
    
    private(set) var nfts: [NftCellModel] = []{
        didSet {
            print("DID set")
            nftsBinding?(nfts)
        }
    }
    private let provider: NftProvider
    
    init(collectionInfo: NftCollection) {
        self.collectionInformation = collectionInfo
        self.provider = NftProvider(networkClient: DefaultNetworkClient())
    }
    
    func fetchNfts() {
        print("fetch nfts")
        var fetchedNfts: [NftCellModel] = []
        let id = collectionInformation.nfts.first!
        print("\(id) to fetch")
        
        let group = DispatchGroup()
        showLoadingHandler?()
        for id in collectionInformation.nfts {
            group.enter()
            print("request started")
            provider.getNftById(id: id) { [weak self] result in
                guard let self = self else {return}
                //print("get response from provider")
                switch result {
                case .success(let nftResult):
                    let cellInfo = NftCellModel(cover: nftResult.images.first!,
                                                name: nftResult.name,
                                                stars: nftResult.rating,
                                                isLiked: self.checkIfNftIsLiked(id: nftResult.id),
                                                price: nftResult.price,
                                                isInCart: self.checkIfNftIsInCart(id: nftResult.id))
                    fetchedNfts.append(cellInfo)
                    print("request finished")
                    group.leave()
                    //print(nftResult)
                    //self.nfts.append(cellInfo)
                    //self.hideLoadingHandler?()
                case .failure(let error):
                    print(error)
                    self.hideLoadingHandler?()
                }
            }
            
        }
        
        group.notify(queue: .main) {
            print("fetched all nft")
            self.hideLoadingHandler?()
            self.nfts = fetchedNfts
        }
        
        
    }
    
    private func checkIfNftIsLiked(id: String) -> Bool {
        return false
    }
    
    private func checkIfNftIsInCart(id: String) -> Bool {
        return false
    }
}
