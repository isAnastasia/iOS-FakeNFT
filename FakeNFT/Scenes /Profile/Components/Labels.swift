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
}


final class Labels: UILabel {

    init(style: LabelsStyle) {
        super.init(frame: .zero)
        commonInit(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(style: LabelsStyle) {
        switch style {
        case .userNameLabelStyle:
            self.font = UIFont.boldSystemFont(ofSize: 22)
            self.text = "Joaquin Phoenix"
            self.textColor = .blackDay
            self.translatesAutoresizingMaskIntoConstraints = false
        case .userDescription:
            self.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            self.text = """
                        Дизайнер из Казани, люблю цифровое искусство и бейглы.
                        В моей коллекции уже 100+ NFT, и еще больше — на моём сайте.
                        Открыт к коллаборациям.
                        """
            self.numberOfLines = 0
            self.textColor = .yaBlackLight
            self.translatesAutoresizingMaskIntoConstraints = false
        case .userWebsite:
            self.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.text = "Joaquin Phoenix.com"
            self.textColor = .yaBlackLight
            self.translatesAutoresizingMaskIntoConstraints = false
            
            
        case .trackerNameLabelStyle:
            self.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            self.textColor = .white
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
            self.translatesAutoresizingMaskIntoConstraints = false
        case .stubLabelForCategoryStyle:
            self.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            self.text = "Привычки и события можно \nобъединить по смыслу"
            self.translatesAutoresizingMaskIntoConstraints = false
            self.heightAnchor.constraint(equalToConstant: 36).isActive = true
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
            self.textAlignment = .center
            self.textColor = UIColor.dynamicLabelColor
        case .newTrackerTitleLabelStyle:
            self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            self.text = "Создание трекера"
            self.translatesAutoresizingMaskIntoConstraints = false
        case .filtersTitleLabelStyle:
            self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            self.text = "Trackers.filters".localized
            self.translatesAutoresizingMaskIntoConstraints = false
            self.textColor = UIColor.dynamicLabelColor
        }
    }

}
