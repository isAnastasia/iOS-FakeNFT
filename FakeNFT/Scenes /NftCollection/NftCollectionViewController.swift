//
//  NftCollectionViewController.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 02.06.2024.
//

import Foundation
import UIKit

struct NftCollection {
    let id: String
    let title: String
    let cover: String
    let author: String
    let description: String
    let nfts: [String]
    
    init(id: String, title: String, cover: String, author: String, description: String, nfts: [String]) {
        self.id = id
        self.title = title
        self.cover = cover
        self.author = author
        self.description = description
        self.nfts = nfts
    }
}

final class NftCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LoadingView {
    var activityIndicator = UIActivityIndicatorView()
    var nftCollectionViewModel: NftCollectionViewModel
    
    private let coverImageView = UIImageView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let nameLabel = UILabel()
    private let authorLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    init(nftCollectionViewModel: NftCollectionViewModel) {
        self.nftCollectionViewModel = nftCollectionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nftCollectionViewModel.showLoadingHandler = { [weak self] in
            guard let self = self else {return}
            self.showLoading()
        }
        
        nftCollectionViewModel.hideLoadingHandler = { [weak self] in
            guard let self = self else {return}
            self.hideLoading()
        }
        
        setUpNavigationBarBackButton()
        
        setUpCollectionCover()
        setUpCollectionNameLabel()
        setUpAuthorLabel()
        setUpDescriptionLabel()
        initCollection()

        
        nftCollectionViewModel.nftsBinding = { [weak self] _ in
            guard let self = self else {return}
            print("binding")
            self.collectionView.reloadData()
            
        }
        nftCollectionViewModel.fetchNfts()
        
    }
    
    //MARK: - Setting Up Collection View
    private func initCollection() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(NftCollectionViewCell.self, forCellWithReuseIdentifier: NftCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(activityIndicator)
        activityIndicator.constraintCenters(to: collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  descriptionLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NftCollectionViewCell.identifier, for: indexPath) as? NftCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepareForReuse()
        //cell.nftModel = mockData.nfts[indexPath.row]
        cell.nftModel = nftCollectionViewModel.nfts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return mockData.nfts.count
        return nftCollectionViewModel.nfts.count
    }
    
    //MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 2 * Constants.insetsBetweenCells - 2 * Constants.leftRightInsets
        let cellWidth =  availableWidth / 3
        
        let cellHeight = cellWidth + Constants.spaceBetweenCoverAndInfo + Constants.infoHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    //MARK: - Setting Up UI
    private func setUpCollectionCover() {
        view.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.image = UIImage(named: "blue.png")
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 12
        coverImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 310)
        ])
    }
    
    private func setUpCollectionNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.textAlignment = .left
        nameLabel.text = nftCollectionViewModel.collectionInformation.title
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 28),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setUpAuthorLabel() {
        view.addSubview(authorLabel)
        let author = "Автор коллекции: " + nftCollectionViewModel.collectionInformation.author
        
        authorLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        authorLabel.textAlignment = .left
        authorLabel.text = author
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.heightAnchor.constraint(equalToConstant: 28),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setUpDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = nftCollectionViewModel.collectionInformation.description
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setUpNavigationBarBackButton() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
    }
}

//MARK: - Constants
private struct Constants {
    static let insetsBetweenCells: Double = 9
    static let leftRightInsets: Double = 16
    static let spaceBetweenCoverAndInfo: Double = 8
    static let infoHeight: Double = 56
}
