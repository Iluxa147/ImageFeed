//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 29.04.2026.
//

import UIKit
import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController {
    private enum WebViewConstants {
        static let unsplashAuthorizeUrlString = "https://unsplash.com/oauth/authorize"
    }
    
    weak var wkNavDelegate: WebViewViewControllerDelegate?
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        loadAuthView()
        
    }
    
    private func loadAuthView() {
        guard var urlAuthComponents =
                URLComponents(string: WebViewConstants.unsplashAuthorizeUrlString) else { return }
        
        urlAuthComponents.queryItems = [
            URLQueryItem(name: "client_id", value: ConstantsApiUnsplash.accessKey),
            URLQueryItem(name: "redirect_uri", value: ConstantsApiUnsplash.redirectUri),
            URLQueryItem(name: "response_type", value: ConstantsApiUnsplash.authResponse),
            URLQueryItem(name: "scope", value: ConstantsApiUnsplash.accessScope)
        ]
        guard let urlAuth = urlAuthComponents.url else { return }
        
        let urlRequest = URLRequest(url: urlAuth)
        webView.load(urlRequest)
    }
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            wkNavDelegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == ConstantsApiUnsplash.authResponse })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
