import UIKit

final class TestCatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let servicesAssembly: ServicesAssembly
    var collectionsViewModel = CatalogCollectionsViewModel()
    
    let testNftButton = UIButton()
    private let tableView = UITableView()
    private var navigationBar: UINavigationBar?

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUpNavigationTabBar()
        initTableView()
        
        collectionsViewModel.collectionsBinding = { [weak self] _ in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
//        view.addSubview(testNftButton)
//        testNftButton.constraintCenters(to: view)
//        testNftButton.setTitle(Constants.openNftTitle, for: .normal)
//        testNftButton.addTarget(self, action: #selector(showNft), for: .touchUpInside)
//        testNftButton.setTitleColor(.systemBlue, for: .normal)
    }
    //MARK: - Actions
    @objc
    func showNft() {
        let assembly = NftDetailAssembly(servicesAssembler: servicesAssembly)
        let nftInput = NftDetailInput(id: Constants.testNftId)
        let nftViewController = assembly.build(with: nftInput)
        present(nftViewController, animated: true)
    }
    
    @objc
    func filterCollections() {
        let alert = UIAlertController(
            title: NSLocalizedString("Filter", comment: ""),
            message: nil,
            preferredStyle: .actionSheet)
        
        let filterByNameAction = UIAlertAction(
            title: NSLocalizedString("Filter.byName", comment: ""),
            style: .default) { [weak self] _ in
                guard let self = self else {return}
                self.collectionsViewModel.filterCollectionsByName()
        }
        alert.addAction(filterByNameAction)
        let filterByCountAction = UIAlertAction(
            title: NSLocalizedString("Filter.byCount", comment: ""),
            style: .default) { [weak self] _ in
                guard let self = self else {return}
                self.collectionsViewModel.filterCollectionsByCount()
        }
        alert.addAction(filterByCountAction)
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
        return 179+8
    }
    
    //MARK: - Setting Up UI
    private func initTableView() {
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
        let addButton = UIBarButtonItem(image: UIImage(systemName: "text.justifyleft"), style: .plain, target: self, action: #selector(filterCollections))
        addButton.tintColor = .segmentActive
        navigationBar?.topItem?.rightBarButtonItem = addButton
    }
    
}

private enum Constants {
    static let openNftTitle = NSLocalizedString("Catalog.openNft", comment: "")
    static let testNftId = "22"
}
