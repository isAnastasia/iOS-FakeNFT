//
//  MyNFTViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//


final class MyNFTViewModel: MyNFTViewModelProtocol {
    
    // MARK: - Public Properties
    var nfts: [MyNFTModel] = [] {
        didSet {
            onNFTsUpdated?()
        }
    }
    
    var onNFTsUpdated: (() -> Void)?
    var onLoadingStatusChanged: ((Bool) -> Void)?
    
    // MARK: - Private Properties
    private let nftService: MyNFTServiceProtocol
    
    // MARK: - Initializers
    init(nftService: MyNFTServiceProtocol) {
        self.nftService = nftService
        loadNFTs()
    }
    
    // MARK: - Public Methods
    func loadNFTs() {
        onLoadingStatusChanged?(true)
        nftService.fetchNFTs { [weak self] result in
            self?.onLoadingStatusChanged?(false)
            switch result {
            case .success(let nfts):
                self?.nfts = nfts
            case .failure(let error):
                print("Failed to load NFTs: \(error)")
            }
        }
    }
    
    func getNFT(at index: Int) -> MyNFTModel? {
        guard index >= 0 && index < nfts.count else { return nil }
        return nfts[index]
    }
    
    func numberOfNFTs() -> Int {
        return nfts.count
    }
    
    // MARK: - Sorting Methods
    func sortByPrice() {
        nfts.sort { $0.price < $1.price }
    }
    
    func sortByRating() {
        nfts.sort { $0.rating > $1.rating }
    }
    
    func sortByName() {
        nfts.sort { $0.name < $1.name }
    }
    
    // MARK: - Sorting Actions
    func getSortActions() -> [SortAction] {
        return [
            SortAction(title: "По цене") { [weak self] in
                self?.sortByPrice()
            },
            SortAction(title: "По рейтингу") { [weak self] in
                self?.sortByRating()
            },
            SortAction(title: "По названию") { [weak self] in
                self?.sortByName()
            }
        ]
    }
}
