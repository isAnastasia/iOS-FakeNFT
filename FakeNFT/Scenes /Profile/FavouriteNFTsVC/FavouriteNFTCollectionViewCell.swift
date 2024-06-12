//
//  FavouriteNFTCollectionViewCell.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

final class FavouriteNFTCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Static Properties
    static let reuseIdentifier = "FavouriteNFTCollectionViewCell"
    
    // MARK: - Private Properties
    private let nftImage = ImageViews(style: .myNFTStyle2)
    private let nftNameLabel = Labels(style: .bold17LabelStyle)
    private let nftValuePriceLabel = Labels(style: .regular15LabelStyle)
    private let nftRatingImage = MyNFTRating()
    private let nftLikeButton = Buttons(style: .largeLikeButtonStyle)
    
    private let descriptionStackView = StackViews(style: .vertical4Style2)
    private let mainStackView = StackViews(style: .vertical8Style2)
    
    private var likeButtonAction: (() -> Void)?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupViewsAndConstraints()
        setupNFTLikeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with nft: MyNFTModel, likeButtonAction: @escaping () -> Void) {
        loadNFTImage(from: nft.images.first)
        nftNameLabel.text = nft.name
        nftValuePriceLabel.text = nft.formattedPrice()
        nftRatingImage.setupRating(rating: nft.rating)
        self.likeButtonAction = likeButtonAction
    }
    
    // MARK: - Private Methods
    private func loadNFTImage(from imageName: String?) {
        guard let imageName = imageName, let imageUrl = URL(string: imageName) else { return }
        nftImage.kf.setImage(with: imageUrl)
    }
    
    private func setupNFTLikeButton() {
        nftLikeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Event Handler (Actions)
    @objc private func likeButtonTapped() {
        likeButtonAction?()
    }
}

extension FavouriteNFTCollectionViewCell {
    // MARK: - Layout
    private func setupViewsAndConstraints() {
        [nftImage, nftLikeButton, mainStackView].forEach {
            contentView.addSubview($0)
        }
        
        [nftNameLabel, nftRatingImage].forEach {
            descriptionStackView.addArrangedSubview($0)
        }
        
        [descriptionStackView, nftValuePriceLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nftImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            nftLikeButton.topAnchor.constraint(equalTo: nftImage.topAnchor),
            nftLikeButton.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor),
            
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
