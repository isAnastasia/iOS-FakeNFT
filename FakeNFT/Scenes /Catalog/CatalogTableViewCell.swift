//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 25.05.2024.
//

import Foundation
import UIKit

final class CatalogTableViewCell: UITableViewCell {
    static let identifier = "CatalogTableViewCell"
    
    let imageCard: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 16
        selectionStyle = .none
        backgroundColor = .white
        setUpImageCard()
        setUpTitle()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpImageCard() {
        contentView.addSubview(imageCard)
        
        imageCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageCard.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCard.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func setUpTitle() {
        contentView.addSubview(title)
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = .black
        title.textAlignment = .left
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            title.topAnchor.constraint(equalTo: imageCard.bottomAnchor, constant: 4),
            title.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}
