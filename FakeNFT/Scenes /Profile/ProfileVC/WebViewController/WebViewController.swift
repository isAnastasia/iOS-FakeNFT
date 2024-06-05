//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 05.06.2024.
//

//import UIKit
//import WebKit
//import ProgressHUD
//
//final class WebViewController: UIViewController {
//    
//    // MARK: - Private Properties
//    private let webView = WKWebView()
//    private let viewModel: WebViewModel
//    
//    // MARK: - Initializers
//    init(viewModel: WebViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - View Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupWebView()
//        setupBindings()
//        viewModel.loadUrl(in: webView)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tabBarController?.tabBar.isHidden = true
//        configureNavigationBarAppearance()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = false
//    }
//    
//    // MARK: - Private Methods
//    private func setupNavigationBar() {
//        navigationController?.navigationBar.tintColor = .blackDay
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blackDay]
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    }
//    
//    private func configureNavigationBarAppearance() {
//        if let navigationBar = navigationController?.navigationBar {
//            navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.isTranslucent = false
//            navigationBar.tintColor = .black
//            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            navigationBar.barTintColor = .white
//        }
//    }
//    
//    private func setupWebView() {
//        view.addSubview(webView)
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//    
//    private func setupBindings() {
//        viewModel.onStateChange = { [weak self] state in
//            switch state {
//            case .idle, .loaded:
//                ProgressHUD.dismiss()
//            case .loading:
//                ProgressHUD.show()
//            case .error(let error):
//                ProgressHUD.dismiss()
//                self?.showError(error)
//            }
//        }
//    }
//    
//    private func showError(_ error: Error) {
//        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//}


import UIKit
import WebKit
import ProgressHUD

final class WebViewController: UIViewController {
    
    // MARK: - Private Properties
    private let webView = WKWebView()
    private let viewModel: WebViewModel
    
    // MARK: - Initializers
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBarAppearance()
        setupWebView()
        setupBindings()
        viewModel.loadUrl(in: webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupNavigationBarAppearance()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Private Methods
    private func setupNavigationBarAppearance() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.tintColor = .blackDay
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blackDay]
        
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.onStateChange = { [weak self] state in
            switch state {
            case .idle, .loaded:
                ProgressHUD.dismiss()
            case .loading:
                ProgressHUD.show()
            case .error(let error):
                ProgressHUD.dismiss()
                self?.showError(error)
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
