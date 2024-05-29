//
//  AboutDeveloperViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 28.5.2024.
//

import UIKit

class AboutDeveloperViewController: UIViewController {
    
    // MARK: - Private Properties
    private let aboutDeveloperImageView = ImageViews(style: .aboutDeveloperStyle)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupViewsAndConstraints()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        navigationItem.title = "О разработчике"
        
        let backButtonImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
        let backBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.tintColor = .blackDay
    }
    
    // MARK: - Event Handler (Actions)
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Layout
extension AboutDeveloperViewController {
    private func setupViewsAndConstraints() {
        view.addSubview(aboutDeveloperImageView)
        
        NSLayoutConstraint.activate([
            aboutDeveloperImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboutDeveloperImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutDeveloperImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutDeveloperImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}