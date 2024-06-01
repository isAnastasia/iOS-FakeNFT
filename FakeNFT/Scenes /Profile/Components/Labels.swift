//
//  Labels.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

enum LabelsStyle {
    case userNameLabelStyle
    case userDescription
    case userWebsite
    case bold17LabelStyle
    case regular15LabelStyle
    case aboutDeveloperLabel
    case nameLabelStyle
    case descriptionLabelStyle
    case websiteLabelStyle
    case regular13LabelStyle
    case myNFTAuthorLabelStyle
    case myNFTPriceLabelStyle
}

final class Labels: UILabel {

    // MARK: - Initializers
    init(style: LabelsStyle, text: String? = nil) {
        super.init(frame: .zero)
        commonInit(style: style, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Label cases
    private func commonInit(style: LabelsStyle, text: String?) {
        switch style {
        case .userNameLabelStyle:
            self.font = UIFont.boldSystemFont(ofSize: 22)
            self.text = text
            self.textColor = .blackDay
        case .userDescription:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.text = text
            self.numberOfLines = 0
            self.textColor = .blackDay
        case .userWebsite:
            self.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.text = text
            self.textColor = .blueUniversal
        case .bold17LabelStyle:
            self.font = UIFont.boldSystemFont(ofSize: 17)
            self.text = text
            self.textColor = .blackDay
        case .regular15LabelStyle:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.text = text
            self.textColor = .blackDay
        case .aboutDeveloperLabel:
            self.font = UIFont.boldSystemFont(ofSize: 17)
            self.text = "О разработчике"
            self.textColor = .blackDay
        case .nameLabelStyle:
            self.font = UIFont.boldSystemFont(ofSize: 17)
            self.text = "Имя"
            self.textColor = .blackDay
        case .descriptionLabelStyle:
            self.font = UIFont.boldSystemFont(ofSize: 17)
            self.text = "Описание"
            self.textColor = .blackDay
        case .websiteLabelStyle:
            self.font = UIFont.boldSystemFont(ofSize: 17)
            self.text = "Сайт"
            self.textColor = .blackDay
        case .regular13LabelStyle:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.textColor = .blackDay
        case .myNFTAuthorLabelStyle:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.text = "от John Doe"
            self.textColor = .blackDay
        case .myNFTPriceLabelStyle:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.text = "Цена"
            self.textColor = .blackDay
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
