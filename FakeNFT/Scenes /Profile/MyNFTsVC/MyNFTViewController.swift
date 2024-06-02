//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit
import ProgressHUD

final class MyNFTViewController: UIViewController {
    
    // MARK: - Public Properties
    private var viewModel: MyNFTViewModelProtocol
    private let tableView = UITableView()
    private let stubLabel = Labels(style: .bold17LabelStyle, text: "У Вас ещё нет NFT")
    
    // MARK: - Initializers
    init(viewModel: MyNFTViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTableView()
        setupStubLabel()
        viewModel.loadNFTs()
    }
    
    // MARK: - Private Methods
    private func bindViewModel() {
        viewModel.onNFTsUpdated = { [weak self] in
            print("NFTs updated in view model: \(self?.viewModel.nfts ?? [])")
            self?.updateView()
        }
        viewModel.onLoadingStatusChanged = { [weak self] isLoading in
            if isLoading {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
                self?.updateView()
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Мои NFT"
        
        let backButtonImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
        let backBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        let sortButtonImage = UIImage(named: "sortButton")?.withRenderingMode(.alwaysOriginal)
        let sortBarButtonItem = UIBarButtonItem(
            image: sortButtonImage,
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = sortBarButtonItem
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .blackDay
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(MyNFTTableViewCell.self, forCellReuseIdentifier: MyNFTTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStubLabel() {
        stubLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubLabel)
        
        NSLayoutConstraint.activate([
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        stubLabel.isHidden = true
    }
    
    private func updateView() {
        if viewModel.numberOfNFTs() == 0 {
            tableView.isHidden = true
            stubLabel.isHidden = false
        } else {
            tableView.isHidden = false
            stubLabel.isHidden = true
        }
        tableView.reloadData()
    }
    
    // MARK: - Event Handler (Actions)
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sortButtonTapped() {
        let actions = viewModel.getSortActions()
        let sortAlert = MyNFTSortAlert().showSortingAlert(actions: actions)
        present(sortAlert, animated: true, completion: nil)
    }
}

 // MARK: - UITableViewDataSource
extension MyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNFTs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNFTTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MyNFTTableViewCell else {
            return UITableViewCell()
        }
        if let nft = viewModel.getNFT(at: indexPath.row) {
            cell.configure(with: nft)
        }
        return cell
    }
}
