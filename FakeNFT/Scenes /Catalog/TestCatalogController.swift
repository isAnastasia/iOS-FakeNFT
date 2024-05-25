import UIKit

final class TestCatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let servicesAssembly: ServicesAssembly
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
        
    }
    
    //MARK: -  Data Source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier, for: indexPath) as? CatalogTableViewCell else {
            return UITableViewCell()
        }
        cell.prepareForReuse()
        cell.imageCard.image = UIImage(named: "cover.png")
        cell.title.text = "Peach (11)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
