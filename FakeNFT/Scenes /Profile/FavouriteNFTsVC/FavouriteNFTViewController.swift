//
//  FavouriteNFTViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

final class FavouriteNFTViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: FavouriteNFTViewModel!
    private let stubLabel = Labels(style: .bold17LabelStyle, text: "У Вас ещё нет избранных NFT")

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FavouriteNFTCollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavouriteNFTViewModel()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupCollectionView()
        setupStubLabel()
        bindViewModel()
        viewModel.loadMockData()
    }

    // MARK: - Private Methods
    private func bindViewModel() {
        viewModel.onNFTsUpdated = { [weak self] in
            self?.updateView()
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = "Избранные NFT"

        let backButtonImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
        let backBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )

        navigationItem.leftBarButtonItem = backBarButtonItem

        navigationController?.navigationBar.tintColor = .blackDay
    }

    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStubLabel() {
        stubLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubLabel)
        
        NSLayoutConstraint.activate([
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func updateView() {
        if viewModel.numberOfNFTs() == 0 {
            collectionView.isHidden = true
            stubLabel.isHidden = false
        } else {
            collectionView.isHidden = false
            stubLabel.isHidden = true
        }
        collectionView.reloadData()
    }

    // MARK: - Event Handler (Actions)
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension FavouriteNFTViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfNFTs()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavouriteNFTCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? FavouriteNFTCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let nft = viewModel.getNFT(at: indexPath.row) {
            cell.configure(with: nft)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouriteNFTViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 16 * 2 + 7
        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

