import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Public Properties
    var servicesAssembly: ServicesAssembly!
    
    //MARK: - Private Properties
    private var tabItems: [(title: String, image: String, selectedImage: String, controller: UIViewController)] = []
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTabbar()
    }
    
    //MARK: - Setup Tabbar and View
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTabbar() {
        tabItems = [
            (
                NSLocalizedString("Tab.profile", comment: ""),
                "profileTabbarNoactive",
                "profileTabbarActive",
                ProfileViewController()
            ),
            (
                NSLocalizedString("Tab.catalog", comment: ""),
                "catalogTabbarNoactive",
                "catalogTabbarActive",
                CatalogViewController()
            ),
            (
                NSLocalizedString("Tab.cart", comment: ""),
                "cartTabbarNoactive",
                "cartTabbarActive",
                CartViewController()
            ),
            (
                NSLocalizedString("Tab.statistics", comment: ""),
                "statisticsTabbarNoactive",
                "statisticsTabbarActive",
                StatisticsViewController()
            )
        ]
        
        var viewControllers = [UIViewController]()
        
        for tabItem in tabItems {
            let tabBarItem = UITabBarItem(
                title: tabItem.title,
                image: UIImage(named: tabItem.image),
                selectedImage: UIImage(named: tabItem.selectedImage)
            )
            let navController = UINavigationController(rootViewController: tabItem.controller)
            navController.tabBarItem = tabBarItem
            viewControllers.append(navController)
        }
        
        self.viewControllers = viewControllers
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
