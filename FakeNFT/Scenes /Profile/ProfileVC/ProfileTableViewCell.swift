//
//  ProfileTableViewCell.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 31.5.2024.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private let label = Labels(style: .bold17LabelStyle)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Properties
    func configure(with text: String) {
        label.text = text
    }
}

// MARK: - Layout
extension ProfileTableViewCell {
    private func setupViewsAndConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
