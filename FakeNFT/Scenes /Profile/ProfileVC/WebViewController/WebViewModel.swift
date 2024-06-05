//
//  WebViewModel.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 05.06.2024.
//

import Foundation
import WebKit

enum WebViewState {
    case idle
    case loading
    case loaded
    case error(Error)
}

final class WebViewModel: NSObject {
    
    // MARK: - Public Properties
    var onStateChange: ((WebViewState) -> Void)?
    private(set) var url: URL
    
    // MARK: - Initializers
    init(url: URL) {
        self.url = url
    }
    
    // MARK: - Public Methods
    func loadUrl(in webView: WKWebView) {
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        onStateChange?(.loading)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewModel: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        onStateChange?(.loaded)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onStateChange?(.error(error))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        onStateChange?(.error(error))
    }
}

