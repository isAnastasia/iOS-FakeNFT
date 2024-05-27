//
//  ImageViews.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

enum ImagesStyle {
    case userPhotoStyle
    case backgroundStyle
    case myNFTStyle
    case myNFTLikeStyle
}

final class ImageViews: UIImageView {
    
    private var shouldApplyCircularCornerRadius = false

    // MARK: - Initializers
    init(style: ImagesStyle) {
        super.init(image: .none)
        commonInit(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Image cases
    private func commonInit(style: ImagesStyle) {
        switch style {
        case .userPhotoStyle:
            self.image = UIImage(named: "userPhoto")
            self.widthAnchor.constraint(equalToConstant: 70).isActive = true
            self.heightAnchor.constraint(equalToConstant: 70).isActive = true
            shouldApplyCircularCornerRadius = true
        case .backgroundStyle:
            self.backgroundColor = .userPhotoEditorBackgroundColor
            self.widthAnchor.constraint(equalToConstant: 70).isActive = true
            self.heightAnchor.constraint(equalToConstant: 70).isActive = true
            shouldApplyCircularCornerRadius = true
        case .myNFTStyle:
            self.widthAnchor.constraint(equalToConstant: 108).isActive = true
            self.heightAnchor.constraint(equalToConstant: 108).isActive = true
            self.layer.cornerRadius = 12
        case .myNFTLikeStyle:
            self.widthAnchor.constraint(equalToConstant: 40).isActive = true
            self.heightAnchor.constraint(equalToConstant: 40).isActive = true
            self.layer.cornerRadius = 12
            self.image = UIImage(named: "favouriteIconWhite")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shouldApplyCircularCornerRadius {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
}
