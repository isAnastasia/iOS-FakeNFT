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

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupViewsAndConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configure(with nft: MyNFTModel1) {
        nftImage.image = UIImage(named: nft.images.first ?? "")
        nftNameLabel.text = nft.name
        nftValuePriceLabel.text = nft.formattedPrice()
        nftRatingImage.setupRating(rating: nft.rating)
    }
}

// MARK: - Layout
extension FavouriteNFTCollectionViewCell {
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
