//
//  MyNFTTableViewCell.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class MyNFTTableViewCell: UITableViewCell {

    // MARK: - Static Properties
    static let reuseIdentifier = "MyNFTTableViewCell"
    
    // MARK: - Public properties
    
    
    // MARK: - Private Properties
    private let cellHeight: CGFloat = 75
    
    private var myNFTImage = ImageViews(style: .myNFTStyle)
    private var myNFTNameLabel = Labels(style: .bold17LabelStyle)
    private var myNFTRatingImage = ImageViews(style: .myNFTRating)
    private let fromLabel = Labels(style: .fromLabelStyle)
    private var myNFTAuthorLabel = Labels(style: .regular13LabelStyle)
    private let myNFTPriceLabel = Labels(style: .regular13LabelStyle)
    private var myNFTValuePriceLabel = Labels(style: .bold17LabelStyle)
    
    private let myNFTDescriptionStackView = StackViews(style: .vertical4Style)
    private let myNFTPriceStackView = StackViews(style: .vertical2Style)
    private let myNFTAuthorStackView = StackViews(style: .horizontal4Style)
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setupViewsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Provate Methods
    func configure(with myNFT: MyNFTModel) {
        self.myNFTImage.image = UIImage(named: myNFT.myNFTImage)
        self.myNFTNameLabel.text = myNFT.myNFTName
        self.myNFTRatingImage.image = UIImage(named: myNFT.myNFTRating)
        self.myNFTAuthorLabel.text = myNFT.myNFTAuthor
        self.myNFTValuePriceLabel.text = myNFT.myNFTPrice
    }

    // MARK: - Layout
    private func setupViewsAndConstraints() {
        [myNFTImage, myNFTDescriptionStackView, myNFTPriceStackView].forEach {
            contentView.addSubview($0)
        }
        
        [myNFTNameLabel, myNFTRatingImage, myNFTAuthorStackView].forEach {
            myNFTDescriptionStackView.addArrangedSubview($0)
        }
        
        [myNFTPriceLabel, myNFTValuePriceLabel].forEach {
            myNFTPriceStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            myNFTImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            myNFTImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myNFTImage.trailingAnchor.constraint(equalTo: myNFTDescriptionStackView.leadingAnchor, constant: -16),
            myNFTImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            myNFTDescriptionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            myNFTDescriptionStackView.trailingAnchor.constraint(equalTo: myNFTPriceStackView.leadingAnchor, constant: -16),
            myNFTDescriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            myNFTPriceStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            myNFTPriceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            myNFTPriceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
