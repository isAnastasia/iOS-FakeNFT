//
//  NftCollectionViewCell.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation
import UIKit
import Kingfisher

final class NftCollectionViewCell: UICollectionViewCell {
    static let identifier = "NftCollectionViewCell"
    
    var nftModel: NftCellModel? {
        didSet {
            guard let model = nftModel else {return}
            self.loadImage(urlString: model.cover)
            nameLabel.text = model.name
            let str = String(model.price) + " ETH"
            priceLabel.text = str
            updateRating(rating: model.stars)
            updateCartButton(isInCart: model.isInCart)
            updateLikeButton(isLiked: model.isLiked)
        }
    }
    
    private let nftImageView = UIImageView()
    private let starsStackView = UIStackView()
    private let likeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "dislike.png"), for: .normal)
        return button
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private let cartButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "noCart.png"), for: .normal)
        return button
    }()
    
    private var starsImages: [UIImageView] = {
        var stars: [UIImageView] = []
        for i in 1...5 {
            if let starImage = UIImage(named: "grayStar.png") {
                stars.append(UIImageView(image: starImage))
            }
        }
        return stars
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setUpImageView()
        setUpStarsStackView()
        setUpCartButton()
        setUpNameLabel()
        setUpPriceLabel()
        setUpLikeButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Actions
    @objc
    func didLikeButtonTapped() {
        //TODO
    }
    
    @objc
    func didCartButtonTapped() {
        //TODO
    }
    
    private func setUpImageView() {
        contentView.addSubview(nftImageView)
        nftImageView.translatesAutoresizingMaskIntoConstraints = false
        nftImageView.layer.masksToBounds = true
        nftImageView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.heightAnchor.constraint(equalTo: nftImageView.widthAnchor, multiplier: 1.0/1.0)
        ])
    }
    
    private func setUpStarsStackView() {
        if let model = nftModel {
            updateRating(rating: model.stars)
        }
        starsStackView.axis = NSLayoutConstraint.Axis.horizontal
        starsStackView.spacing = 2
        starsImages.forEach { starImageView in
            starsStackView.addArrangedSubview(starImageView)
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                starImageView.widthAnchor.constraint(equalToConstant: 12),
                starImageView.heightAnchor.constraint(equalToConstant: 12)
            ])
        }
        
        contentView.addSubview(starsStackView)
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            starsStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            starsStackView.widthAnchor.constraint(equalToConstant: 68),
            starsStackView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    private func setUpCartButton() {
        contentView.addSubview(cartButton)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.addTarget(self, action: #selector(didCartButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setUpLikeButton() {
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(didLikeButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setUpNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            nameLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor)
        ])
    }
    
    private func setUpPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.heightAnchor.constraint(equalToConstant: 12),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor)
        ])
    }
    
    private func updateRating(rating: Int) {
        for i in 0..<rating {
            if let starImage = UIImage(named: "goldStar.png") {
                starsImages[i].image = starImage
            }
        }
    }
    
    private func updateCartButton(isInCart: Bool) {
        if isInCart {
            cartButton.setImage(UIImage(named: "cart.png"), for: .normal)
        } else {
            cartButton.setImage(UIImage(named: "noCart.png"), for: .normal)
        }
    }
    
    private func updateLikeButton(isLiked: Bool) {
        if isLiked {
            likeButton.setImage(UIImage(named: "like.png"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "dislike.png"), for: .normal)
        }
    }
    
    private func loadImage(urlString: String) {
        guard let encodingStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            print("error converting url")
            return
        }
        let processor = RoundCornerImageProcessor(cornerRadius: 16)
        if let imageUrl = URL(string: encodingStr) {
            nftImageView.kf.indicatorType = .activity
            nftImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "Card.png"), options: [.processor(processor)])
            nftImageView.contentMode = .scaleAspectFill
            nftImageView.layer.cornerRadius = 16
            nftImageView.layer.masksToBounds = false
            nftImageView.clipsToBounds = true
        }
    }
}
