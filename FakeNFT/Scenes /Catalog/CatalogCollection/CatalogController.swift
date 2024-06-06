import UIKit

final class CatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ErrorView, LoadingView {
    lazy var activityIndicator = UIActivityIndicatorView()
    
    var collectionsViewModel = CatalogCollectionsViewModel()
    
    private let tableView = UITableView()
    private var navigationBar: UINavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUpNavigationTabBar()
        initTableView()
        
        collectionsViewModel.collectionsBinding = { [weak self] _ in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
        
        collectionsViewModel.errorBinding = { [weak self] in
            guard let self = self else {return}
            self.showErrorAlert()
        }
        
        collectionsViewModel.showLoadingHandler = { [weak self] in
            guard let self = self else {return}
            self.showLoading()
        }
        
        collectionsViewModel.hideLoadingHandler = { [weak self] in
            guard let self = self else {return}
            self.hideLoading()
        }
        collectionsViewModel.fetchCollections()
    }
    //MARK: - Actions
    @objc
    func sortCollectionsButtonTapped() {
        let alert = UIAlertController(
            title: NSLocalizedString("Sorting", comment: ""),
            message: nil,
            preferredStyle: .actionSheet)
        
        let sortByNameAction = UIAlertAction(
            title: NSLocalizedString("Sorting.byName", comment: ""),
            style: .default) { [weak self] _ in
                guard let self = self else {return}
                self.collectionsViewModel.sortingChanged(newSorting: SortingTypes.ByName)
        }
        alert.addAction(sortByNameAction)
        let sortByCountAction = UIAlertAction(
            title: NSLocalizedString("Sorting.byCount", comment: ""),
            style: .default) { [weak self] _ in
                guard let self = self else {return}
                self.collectionsViewModel.sortingChanged(newSorting: SortingTypes.ByNftCount)
        }
        alert.addAction(sortByCountAction)
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Close", comment: ""),
            style: .cancel))
        
        present(alert, animated: true)
    }
    
    //MARK: -  Data Source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier, for: indexPath) as? CatalogTableViewCell else {
            return UITableViewCell()
        }
        cell.prepareForReuse()
        cell.viewModel = collectionsViewModel.collections[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionsViewModel.collections.count
    }
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 179 + 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = collectionsViewModel.collections[indexPath.row].collection
        let viewModel = NftCollectionViewModel(collectionInfo: NftCollection(
            id: collection.id,
            title: collection.title,
            cover: collection.cover,
            author: collection.author,
            description: collection.description,
            nfts: collection.nfts))
        let vc = NftCollectionViewController(nftCollectionViewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Setting Up UI
    private func initTableView() {
        tableView.addSubview(activityIndicator)
        activityIndicator.constraintCenters(to: tableView)
        
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpNavigationTabBar() {
        navigationBar = navigationController?.navigationBar
        let addButton = UIBarButtonItem(image: UIImage(named: "sort.png") ?? UIImage(systemName: "text.justifyleft"), style: .plain, target: self, action: #selector(sortCollectionsButtonTapped))
        addButton.tintColor = .segmentActive
        navigationBar?.topItem?.rightBarButtonItem = addButton
    }
    
    //MARK: - Error Alert
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("Error.title", comment: ""),
            message: NSLocalizedString("Error.network", comment: ""),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Ok", comment: ""),
            style: .cancel,
            handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
