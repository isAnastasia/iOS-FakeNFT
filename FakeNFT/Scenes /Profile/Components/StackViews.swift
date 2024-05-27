//
//  StackViews.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

enum StackViewStyle {
    case vertical8Style
    case horizontal16Style
    case vertical24Style
    case vertical4Style
    case vertical2Style
    case horizontal4Style
    case myNFTDescriptionStyle
    case myNFTPriceStyle
}

final class StackViews: UIStackView {

    // MARK: - Initializers
    init(style: StackViewStyle) {
        super.init(frame: .zero)
        commonInit(style: style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - StackView cases
    private func commonInit(style: StackViewStyle) {
        switch style {
        case .vertical8Style:
            self.axis = .vertical
            self.spacing = 8
            self.alignment = .fill
            self.distribution = .fill
        case .vertical24Style:
            self.axis = .vertical
            self.spacing = 24
            self.alignment = .fill
            self.distribution = .fill
        case .horizontal16Style:
            self.axis = .horizontal
            self.spacing = 16
            self.alignment = .fill
            self.distribution = .fill
        case .vertical4Style:
            self.axis = .vertical
            self.spacing = 4
            self.alignment = .fill
            self.distribution = .fill
        case .vertical2Style:
            self.axis = .vertical
            self.spacing = 2
            self.alignment = .fill
            self.distribution = .fill
        case .horizontal4Style:
            self.axis = .horizontal
            self.spacing = 4
            self.alignment = .fill
            self.distribution = .fill
        case .myNFTDescriptionStyle:
            self.axis = .vertical
            self.spacing = 4
            self.alignment = .leading
            self.distribution = .equalSpacing
            self.widthAnchor.constraint(equalToConstant: 78).isActive = true
            self.heightAnchor.constraint(equalToConstant: 62).isActive = true
        case .myNFTPriceStyle:
            self.axis = .vertical
            self.spacing = 2
            self.alignment = .leading
            self.distribution = .equalSpacing
            self.widthAnchor.constraint(equalToConstant: 75).isActive = true
            self.heightAnchor.constraint(equalToConstant: 42).isActive = true
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
