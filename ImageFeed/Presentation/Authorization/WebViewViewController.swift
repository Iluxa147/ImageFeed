//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 29.04.2026.
//

import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Properties
    
    weak var delegate: WebViewViewControllerDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    // MARK: - Constants
    private enum Constants {
        static let unsplashAuthorizeUrlString = "https://unsplash.com/oauth/authorize"
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        loadAuthView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        addObserver()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeObserver()
    }
    
    // MARK: - Private members
    
    private func loadAuthView() {
        guard var urlAuthComponents = URLComponents(string: Constants.unsplashAuthorizeUrlString)
        else { return }
        
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

// MARK: - WKNavigationDelegate
extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        guard
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let code = urlComponents.queryItems?
                .first(where: { $0.name == ConstantsApiUnsplash.authResponse })?
                .value
        else { return nil }
        
        return code
    }
}

// MARK: - ProgressBar
extension WebViewViewController {
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func addObserver() {
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil)
        updateProgress()
    }
    
    private func removeObserver() {
        webView.removeObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            context: nil)
    }
    
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
}

