//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

final class MyNFTViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: MyNFTViewModel!
    private let tableView = UITableView()
    private let stubLabel = Labels(style: .bold17LabelStyle, text: "У Вас ещё нет NFT")
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyNFTViewModel()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTableView()
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
        let actions = [
            SortAction(title: "По цене") { [weak self] in
                self?.viewModel.sortByPrice()
            },
            SortAction(title: "По рейтингу") { [weak self] in
                self?.viewModel.sortByRating()
            },
            SortAction(title: "По названию") { [weak self] in
                self?.viewModel.sortByName()
            }
        ]
        
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

