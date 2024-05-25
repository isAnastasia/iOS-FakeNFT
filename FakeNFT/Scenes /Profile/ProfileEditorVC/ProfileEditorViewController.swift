//
//  ProfileEditorViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class ProfileEditorViewController: UIViewController {
    
    var viewModel: ProfileEditorViewModel?
    var onProfileUpdated: ((UserProfile) -> Void)?
    
    // MARK: - Private Properties
    private lazy var nameTF = TextFields(
        style: .defaultTFStyle,
        target: self,
        action: #selector(nameTFDidChange(_:))
    )
    
    private lazy var websiteTF = TextFields(
        style: .defaultTFStyle,
        target: self,
        action: #selector(websiteTFDidChange(_:))
    )
    
    private lazy var descriptionTV: TextViews = {
        let textView = TextViews(style: .defaultTVStyle) { [weak self] textView in
            self?.descriptionTVDidChange(textView)
        }
        return textView
    }()
    
    private let closeButton = Buttons(style: .closeButtonStyle)
    
    private let userPhotoImage = ImageViews(style: .userPhotoStyle)
    private let userPhotoBackgroundImage = ImageViews(style: .backgroundStyle)
    private let userPhotoEditorButton = Buttons(style: .userPhotoEditor)
    
    private let nameLabel = Labels(style: .nameLabelStyle)
    private let descriptionLabel = Labels(style: .descriptionLabelStyle)
    private let websiteLabel = Labels(style: .websiteLabelStyle)
    
    private let nameStackView = StackViews(style: .vertical8Style)
    private let descriptionStackView = StackViews(style: .vertical8Style)
    private let websiteeStackView = StackViews(style: .vertical8Style)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewsAndConstraints()
        setupCloseButtonAction()
        setupInitialValues()
    }
    
    // MARK: - Private Methods
    private func setupCloseButtonAction() {
        closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func setupUserPhotoEditorButtonAction() {
        userPhotoEditorButton.addTarget(
            self,
            action: #selector(userPhotoEditorButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func setupInitialValues() {
        guard let profile = viewModel?.userProfile else { return }
        nameTF.text = profile.userName
        descriptionTV.text = profile.userDescription
        websiteTF.text = profile.userWebsite
        userPhotoImage.image = profile.userPhoto
    }
    
    // MARK: - Event Handler (Actions)
    @objc private func closeButtonTapped() {
        viewModel?.updateUserName(nameTF.text ?? "")
        viewModel?.updateUserDescription(descriptionTV.text)
        viewModel?.updateUserWebsite(websiteTF.text ?? "")
        if let updatedProfile = viewModel?.userProfile {
            onProfileUpdated?(updatedProfile)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func userPhotoEditorButtonTapped() {
        
    }
    
    @objc private func nameTFDidChange(_ textField: UITextField) {
        viewModel?.updateUserName(textField.text ?? "")
    }
    
    @objc private func websiteTFDidChange(_ textField: UITextField) {
        viewModel?.updateUserWebsite(textField.text ?? "")
    }
    
    @objc private func descriptionTVDidChange(_ textView: UITextView) {
        viewModel?.updateUserDescription(textView.text)
    }
}

// MARK: - Layout
extension ProfileEditorViewController {
    private func setupViewsAndConstraints() {
        [closeButton, userPhotoImage, userPhotoBackgroundImage, userPhotoEditorButton, nameStackView, descriptionStackView, websiteeStackView].forEach {
            view.addSubview($0)
        }
        
        [nameLabel, nameTF].forEach {
            nameStackView.addArrangedSubview($0)
        }
        
        [descriptionLabel, descriptionTV].forEach {
            descriptionStackView.addArrangedSubview($0)
        }
        
        [websiteLabel, websiteTF].forEach {
            websiteeStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            userPhotoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            userPhotoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userPhotoBackgroundImage.centerYAnchor.constraint(equalTo: userPhotoImage.centerYAnchor),
            userPhotoBackgroundImage.centerXAnchor.constraint(equalTo: userPhotoImage.centerXAnchor),
            
            userPhotoEditorButton.centerXAnchor.constraint(equalTo: userPhotoImage.centerXAnchor),
            userPhotoEditorButton.centerYAnchor.constraint(equalTo: userPhotoImage.centerYAnchor),
            
            nameStackView.topAnchor.constraint(equalTo: userPhotoImage.bottomAnchor, constant: 24),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 24),
            descriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            websiteeStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 24),
            websiteeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            websiteeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

