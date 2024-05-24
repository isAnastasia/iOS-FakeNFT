//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Public Properties
    
    
    // MARK: - Private Properties
    private let editButton = Buttons(style: .editButtonStyle)
    private let userPhotoImage = ImageViews(style: .userPhotoStyle)
    private let userNameLabel = Labels(style: .userNameLabelStyle)
    private let userDescriptionLabel = Labels(style: .userDescription)
    private let userWebsiteLabel = Labels(style: .userWebsite)
    
    private let userPhotoAndNameStackView = StackViews(style: .horizontal16Style)
    private let userInfoStackView = StackViews(style: .vertical8Style)
    
    private var myNftCount = 0 {
        didSet {
            updateLabel(myNftLabel, withText: "Мои NFT (\(myNftCount))")
        }
    }
    
    private var favoriteNftCount = 0 {
        didSet {
            updateLabel(favoriteNftLabel, withText: "Избранные NFT (\(favoriteNftCount))")
        }
    }
    
    private let myNftLabel = Labels(style: .myNftLabel, text: "Мои NFT (0)")
    private let favoriteNftLabel = Labels(style: .favoriteNftLabel, text: "Избранные NFT (0)")
    private let aboutDeveloperLabel = Labels(style: .aboutDeveloperLabel)
    
    
    private let tableView = UITableView()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewsAndConstraints()
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 54
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.myNftCount = 112
            self.favoriteNftCount = 11
        }
    }
    
    private func updateLabel(_ label: Labels, withText text: String) {
        label.text = text
    }
    
    private func customAccessoryView() -> UIView {
        let accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
        accessoryView.tintColor = .blackDay
        return accessoryView
    }
}

// MARK: - Layout
extension ProfileViewController {
    private func setupViewsAndConstraints() {
        [editButton, userPhotoAndNameStackView, userInfoStackView, tableView].forEach {
            view.addSubview($0)
        }
        
        [userPhotoImage, userNameLabel].forEach {
            userPhotoAndNameStackView.addArrangedSubview($0)
        }
        
        [userDescriptionLabel, userWebsiteLabel].forEach {
            userInfoStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            
            userPhotoAndNameStackView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            userPhotoAndNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userPhotoAndNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            userInfoStackView.topAnchor.constraint(equalTo: userPhotoAndNameStackView.bottomAnchor, constant: 20),
            userInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: userInfoStackView.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 162)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var label: UILabel
        
        switch indexPath.row {
        case 0:
            label = myNftLabel
        case 1:
            label = favoriteNftLabel
        case 2:
            label = aboutDeveloperLabel
        default:
            label = UILabel()
        }
        
        cell.accessoryView = customAccessoryView()
        cell.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        return cell
    }
}
