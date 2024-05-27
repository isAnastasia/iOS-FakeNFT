//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

class MyNFTViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: MyNFTViewModel!
    private let tableView = UITableView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyNFTViewModel()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTableView()
        bindViewModel()
        viewModel.loadMockData()
    }
    
    // MARK: - Private Methods
    private func bindViewModel() {
        viewModel.onNFTsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Мои NFT"
        
        let backButtonImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
        let backBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        
        let sortButtonImage = UIImage(named: "sortButton")?.withRenderingMode(.alwaysOriginal)
        let sortBarButtonItem = UIBarButtonItem(image: sortButtonImage, style: .plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = sortBarButtonItem
        
        navigationController?.navigationBar.tintColor = .black
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
    
    // MARK: - Event Handler (Actions)
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNFTs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyNFTTableViewCell.reuseIdentifier, for: indexPath) as? MyNFTTableViewCell else {
            return UITableViewCell()
        }
        if let nft = viewModel.getNFT(at: indexPath.row) {
            cell.configure(with: nft)
        }
        return cell
    }
}
