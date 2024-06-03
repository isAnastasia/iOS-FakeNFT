//
//  AuthorWebViewController.swift
//  FakeNFT
//
//  Created by Anastasia Gorbunova on 03.06.2024.
//

import UIKit
import WebKit

final class AuthorWebViewController: UIViewController, WKNavigationDelegate, LoadingView {
    var activityIndicator = UIActivityIndicatorView()
    private lazy var webView: WKWebView = {
        let wv = WKWebView(frame: view.frame)
        wv.navigationDelegate = self
        return wv
    }()
    
    private let websiteLinkString: String
    
    init(websiteLinkString: String) {
        self.websiteLinkString = websiteLinkString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        loadWebView()
    }
    
    //MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideLoading()
        self.showErrorAlert()
    }
    
    //MARK: - Setting Up UI
    private func setUpUI() {
        setUpNavigationBarBackButton()
        setUpWebView()
        setUpActivityIndicator()
    }
    
    private func setUpNavigationBarBackButton() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
    }
    
    private func setUpWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        activityIndicator.constraintCenters(to: view)
    }
    
    //MARK: - Private methods
    private func loadWebView() {
        if let url = URL(string: websiteLinkString) {
            webView.load(URLRequest(url: url))
        } else {
            showErrorAlert()
        }
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
