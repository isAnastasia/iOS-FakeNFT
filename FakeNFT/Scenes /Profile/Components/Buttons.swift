//
//  Buttons.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

enum ButtonsStyle {
    case editButtonStyle
}

final class Buttons: UIButton {
    
    // MARK: - Initializers
    init(style: ButtonsStyle) {
        super.init(frame: .zero)
        commonInit(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button cases
    private func commonInit(style: ButtonsStyle) {
        switch style {
            
        case .editButtonStyle:
            self.setImage(UIImage(named: "editButton"), for: .normal)
            self.widthAnchor.constraint(equalToConstant: 34).isActive = true
            self.heightAnchor.constraint(equalToConstant: 34).isActive = true
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
