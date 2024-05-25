//
//  Buttons.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

enum ButtonsStyle {
    case editButtonStyle
    case closeButtonStyle
    case userPhotoEditor
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
        case .closeButtonStyle:
            self.setImage(UIImage(named: "closeButton"), for: .normal)
            self.widthAnchor.constraint(equalToConstant: 42).isActive = true
            self.heightAnchor.constraint(equalToConstant: 42).isActive = true
        case .userPhotoEditor:
            self.setTitle("Сменить\nфото", for: .normal)
            self.setTitleColor(.whiteDay, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
            self.titleLabel?.numberOfLines = 2
            self.titleLabel?.textAlignment = .center
            self.widthAnchor.constraint(equalToConstant: 45).isActive = true
            self.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
