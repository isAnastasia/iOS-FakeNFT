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
    case myNftLabel
    case favoriteNftLabel
    case aboutDeveloperLabel
    case nameLabelStyle
    case descriptionLabelStyle
    case websiteLabelStyle
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
            self.text = "Joaquin Phoenix"
            self.textColor = .blackDay
        case .userDescription:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.text = """
                        Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.
                        """
            self.numberOfLines = 0
            self.textColor = .blackDay
        case .userWebsite:
            self.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.text = "Joaquin Phoenix.com"
            self.textColor = .blueUniversal
        case .myNftLabel, .favoriteNftLabel:
            self.font = UIFont.boldSystemFont(ofSize: 17)
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
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
