//
//  MyNFTRating.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 26.5.2024.
//

import UIKit

final class MyNFTRating: UIStackView {
    
    // MARK: - Private Properties
    private lazy var yellowStarsImage: UIImage? = UIImage(named: "NFTRatingYellow")
    private lazy var whiteStarsImage: UIImage? = UIImage(named: "NFTRatingWhite")
    private var currentRating: Int = 0
    
    // MARK: - Initializers
    init(rating: Int = 5) {
        super.init(frame: .zero)
        setupStackView()
        addStarImageViews(count: 5)
        setupRating(rating: rating)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupStackView() {
        axis = .horizontal
        spacing = 2
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createStarImageView(tag: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = whiteStarsImage
        imageView.tag = tag
        return imageView
    }
    
    private func addStarImageViews(count: Int) {
        for index in 1...count {
            let imageView = createStarImageView(tag: index)
            addArrangedSubview(imageView)
        }
    }
    
    // MARK: - Public Methods
    func setupRating(rating: Int) {
        currentRating = max(0, min(rating, 5))
        
        for view in arrangedSubviews {
            if let imageView = view as? UIImageView {
                imageView.image = imageView.tag > currentRating 
                ? whiteStarsImage
                : yellowStarsImage
            }
        }
    }
}

