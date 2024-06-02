//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 24.5.2024.
//

import UIKit
import ProgressHUD

final class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private var viewModel: ProfileViewModel?
    
    private lazy var editButton: UIBarButtonItem = {
        let buttonImage = UIImage(named: "editButton")?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(
            image: buttonImage,
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        return button
    }()
    
    private let userPhotoImage = ImageViews(style: .userPhotoStyle)
    private let userNameLabel = Labels(style: .userNameLabelStyle)
    private let userDescriptionLabel = Labels(style: .userDescription)
    private let userWebsiteLabel = Labels(style: .userWebsite)
    
    private let userPhotoAndNameStackView = StackViews(style: .horizontal16Style)
    private let userInfoStackView = StackViews(style: .vertical8Style)
    
    private let myNftLabel = Labels(style: .bold17LabelStyle, text: "Мои NFT (0)")
    private let favoriteNftLabel = Labels(style: .bold17LabelStyle, text: "Избранные NFT (0)")
    private let aboutDeveloperLabel = Labels(style: .aboutDeveloperLabel)
    
    private let tableView = UITableView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel = ProfileViewModel(profileNetworkService: ProfileNetworkService())
        setupViewsAndConstraints()
        setupTableView()
        setupBindings()
        setupNavigationBar()
        viewModel?.loadData()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        viewModel?.onProfileDataUpdated = { [weak self] in
            self?.updateUI()
        }
        viewModel?.onLoadingStatusChanged = { isLoading in
            if isLoading {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }
    }
    
    private func updateUI() {
        guard let profile = viewModel?.userProfile else { return }
        userNameLabel.text = profile.name
        userDescriptionLabel.text = profile.description
        userWebsiteLabel.text = profile.website
        myNftLabel.text = "Мои NFT (\(profile.nfts.count))"
        favoriteNftLabel.text = "Избранные NFT (\(profile.likes.count))"
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.rowHeight = 54
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }
    
    private func customAccessoryView() -> UIView {
        let accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
        accessoryView.tintColor = .blackDay
        return accessoryView
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
    }
    
    // MARK: - Event Handler (Actions)
    @objc private func editButtonTapped() {
        guard let profile = viewModel?.userProfile else { return }
        let profileEditorViewModel = ProfileEditorViewModel(profile: profile)
        let profileEditorVC = ProfileEditorViewController(viewModel: profileEditorViewModel)
        profileEditorViewModel.onProfileUpdated = { [weak self] updatedProfile in
            self?.viewModel?.userProfile = updatedProfile
            self?.viewModel?.onProfileDataUpdated?()
        }
        present(profileEditorVC, animated: true, completion: nil)
    }
}

// MARK: - Layout
extension ProfileViewController {
    private func setupViewsAndConstraints() {
        [userPhotoAndNameStackView, userInfoStackView, tableView].forEach {
            view.addSubview($0)
        }
        
        [userPhotoImage, userNameLabel].forEach {
            userPhotoAndNameStackView.addArrangedSubview($0)
        }
        
        [userDescriptionLabel, userWebsiteLabel].forEach {
            userInfoStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            userPhotoAndNameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        var text = ""
        switch indexPath.row {
        case 0:
            text = myNftLabel.text ?? ""
        case 1:
            text = favoriteNftLabel.text ?? ""
        case 2:
            text = aboutDeveloperLabel.text ?? ""
        default:
            break
        }
        
        cell.configure(with: text)
        cell.accessoryView = customAccessoryView()
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let nftService = MyNFTService()
            let myNFTViewModel = MyNFTViewModel(nftService: nftService)
            let myNFTVC = MyNFTViewController(viewModel: myNFTViewModel)
            navigationController?.pushViewController(myNFTVC, animated: true)
        case 1:
            let favouriteNFTViewModel = FavouriteNFTViewModel()
            let favouriteNFTVC = FavouriteNFTViewController(viewModel: favouriteNFTViewModel)
            navigationController?.pushViewController(favouriteNFTVC, animated: true)
        case 2:
            let aboutDeveloperVC = AboutDeveloperViewController()
            navigationController?.pushViewController(aboutDeveloperVC, animated: true)
        default:
            break
        }
    }
}
