//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class MyNFTViewController: UIViewController {
    
    private let myNftLabel = Labels(style: .bold17LabelStyle, text: "Мои NFT")
    private let backButton = Buttons(style: .backButtonStyle)
    private let sortButton = Buttons(style: .sortButtonStyle)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewsAndConstraints()
        setupBackButtonAction()
    }
    
    // MARK: - Private Methods
    private func setupBackButtonAction() {
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Event Handler (Actions)
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Layout
extension MyNFTViewController {
    private func setupViewsAndConstraints() {
        [backButton, myNftLabel, sortButton].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            
            myNftLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myNftLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
        ])
    }
}
