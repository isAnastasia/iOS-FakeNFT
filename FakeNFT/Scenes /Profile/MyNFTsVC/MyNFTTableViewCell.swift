//
//  MyNFTTableViewCell.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit
import Kingfisher

final class MyNFTTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let reuseIdentifier = "MyNFTTableViewCell"
    
    // MARK: - Public properties
    
    // MARK: - Private Properties
    private let cellHeight: CGFloat = 140
    
    private let myNFTNameLabel = Labels(style: .bold17LabelStyle)
    private let myNFTAuthorLabel = Labels(style: .myNFTAuthorLabelStyle)
    
    private let myNFTPriceLabel = Labels(style: .myNFTPriceLabelStyle)
    private let myNFTValuePriceLabel = Labels(style: .bold17LabelStyle)
    
    private let myNFTImage = ImageViews(style: .myNFTStyle)
    private let myNFTLikeButton = Buttons(style: .smallLikeButtonStyle)
    
    private let myNFTRatingImage = MyNFTRating()
    
    private let myNFTDescriptionStackView = StackViews(style: .myNFTDescriptionStyle)
    private let myNFTPriceStackView = StackViews(style: .myNFTPriceStyle)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setupViewsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with myNFT: MyNFTModel) {
        loadNFTImage(from: myNFT.images.first)
        myNFTNameLabel.text = myNFT.name
        myNFTValuePriceLabel.text = myNFT.formattedPrice()
        myNFTRatingImage.setupRating(rating: myNFT.rating)
    }
    
    // MARK: - Private Methods
    private func loadNFTImage(from imageName: String?) {
        guard let imageName = imageName else { return }
        myNFTImage.image = UIImage(named: imageName)
    }
    
    private func formattedPrice(from price: Double) -> String {
        return String(format: "%.2f ETH", price).replacingOccurrences(of: ".", with: ",")
    }
}

extension MyNFTTableViewCell {
    // MARK: - Layout
    private func setupViewsAndConstraints() {
        [myNFTImage, myNFTLikeButton, myNFTDescriptionStackView, myNFTPriceStackView].forEach {
            contentView.addSubview($0)
        }
        
        [myNFTNameLabel, myNFTRatingImage, myNFTAuthorLabel].forEach {
            myNFTDescriptionStackView.addArrangedSubview($0)
        }
        
        [myNFTPriceLabel, myNFTValuePriceLabel].forEach {
            myNFTPriceStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            myNFTImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            myNFTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myNFTImage.trailingAnchor.constraint(equalTo: myNFTDescriptionStackView.leadingAnchor, constant: -20),
            myNFTImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            myNFTLikeButton.topAnchor.constraint(equalTo: myNFTImage.topAnchor, constant: 0),
            myNFTLikeButton.trailingAnchor.constraint(equalTo: myNFTImage.trailingAnchor, constant: 0),
            
            myNFTDescriptionStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myNFTDescriptionStackView.trailingAnchor.constraint(equalTo: myNFTPriceStackView.leadingAnchor, constant: -39),
            
            myNFTPriceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

