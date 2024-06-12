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
    
    // MARK: - Private Properties
    private let cellHeight: CGFloat = 140
    
    private let myNFTNameLabel = Labels(style: .bold17LabelStyle)
    private let myNFTAuthorLabel = Labels(style: .myNFTAuthorLabelStyle)
    
    private let myNFTPriceLabel = Labels(style: .myNFTPriceLabelStyle)
    private let myNFTValuePriceLabel = Labels(style: .myNFTPriceValueLabelStyle)
    
    private let myNFTImage = ImageViews(style: .myNFTStyle)
    private let myNFTLikeButton = Buttons(style: .smallLikeButtonStyle)
    
    private let myNFTRatingImage = MyNFTRating()
    
    private let myNFTDescriptionStackView = StackViews(style: .myNFTDescriptionStyle)
    private let myNFTPriceStackView = StackViews(style: .myNFTPriceStyle)
    private let myNFTMainStackView = StackViews(style: .horizontal39Style)
    
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
        myNFTAuthorLabel.text = "от \(myNFT.authorName)"
    }
    
    // MARK: - Private Methods
    private func loadNFTImage(from imageName: String?) {
        guard let imageName = imageName, let imageUrl = URL(string: imageName) else { return }
        myNFTImage.kf.setImage(with: imageUrl)
    }
}

extension MyNFTTableViewCell {
    // MARK: - Layout
    private func setupViewsAndConstraints() {
        [myNFTImage, myNFTLikeButton, myNFTMainStackView].forEach {
            contentView.addSubview($0)
        }
        
        [myNFTNameLabel, myNFTRatingImage, myNFTAuthorLabel].forEach {
            myNFTDescriptionStackView.addArrangedSubview($0)
        }
        
        [myNFTPriceLabel, myNFTValuePriceLabel].forEach {
            myNFTPriceStackView.addArrangedSubview($0)
        }
        
        [myNFTDescriptionStackView, myNFTPriceStackView].forEach {
            myNFTMainStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            myNFTImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            myNFTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myNFTImage.trailingAnchor.constraint(equalTo: myNFTMainStackView.leadingAnchor, constant: -20),
            myNFTImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            myNFTLikeButton.topAnchor.constraint(equalTo: myNFTImage.topAnchor, constant: 0),
            myNFTLikeButton.trailingAnchor.constraint(equalTo: myNFTImage.trailingAnchor, constant: 0),
            
            myNFTMainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            myNFTMainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
