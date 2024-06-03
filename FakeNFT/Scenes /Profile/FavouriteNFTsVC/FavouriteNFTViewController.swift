//
//  FavouriteNFTViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit
import ProgressHUD

final class FavouriteNFTViewController: UIViewController {

    // MARK: - Public Properties
    var onFavouritesCountUpdated: ((Int) -> ())?
    
    // MARK: - Private Properties
    private var viewModel: FavouriteNFTViewModelProtocol
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FavouriteNFTCollectionViewCell.self, forCellWithReuseIdentifier: FavouriteNFTCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    private let stubLabel = Labels(style: .bold17LabelStyle, text: "У Вас ещё нет избранных NFT")

    // MARK: - Initializers
    init(viewModel: FavouriteNFTViewModelProtocol = FavouriteNFTViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupCollectionView()
        setupStubLabel()
        viewModel.loadFavouriteNFTs()
    }

    // MARK: - Private Methods
    private func bindViewModel() {
        viewModel.onNFTsUpdated = { [weak self] in
            self?.updateView()
        }
        viewModel.onLoadingStatusChanged = { [weak self] isLoading in
            if isLoading {
                ProgressHUD.show()
                self?.stubLabel.isHidden = true
                self?.collectionView.isHidden = true
            } else {
                ProgressHUD.dismiss()
                self?.updateView()
            }
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
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStubLabel() {
        view.addSubview(stubLabel)
        stubLabel.translatesAutoresizingMaskIntoConstraints = false
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
            cell.configure(with: nft) { [weak self] in
                self?.viewModel.unlikeNFT(at: indexPath.row)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouriteNFTViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let totalSpacing: CGFloat = 16 * 2 + 7
        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 80)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 7
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
