//
//  ImageViews.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

enum ImagesStyle {
    case userPhotoStyle
}

final class ImageViews: UIImageView {
    
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
            self.layer.cornerRadius = self.frame.width / 2
            self.widthAnchor.constraint(equalToConstant: 70).isActive = true
            self.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
