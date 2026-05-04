//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 29.04.2026.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}

final class AuthViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var buttonAuthorize: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: AuthViewControllerDelegate?
    private let authService = OAuth2Service.shared
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    // MARK: - Constants
    private enum Constants {
        static let buttonAuthorizeText = "Войти"
        static let buttonNavBackWhiteName = "button_nav_back_white"
        static let showWebViewSegueIdentifier = "ShowWebView"
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAuthorize.layer.cornerRadius = 16
        configureBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension AuthViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.showWebViewSegueIdentifier else {
            super.prepare(for: segue, sender: sender)
            return
        }
        
        guard let webViewViewController = segue.destination as? WebViewViewController else {
            assertionFailure("Failed to prepare for segue \(Constants.showWebViewSegueIdentifier)")
            return
        }
        
        webViewViewController.delegate = self
    }
    
    // MARK: - UI Initialisation
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: Constants.buttonNavBackWhiteName)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: Constants.buttonNavBackWhiteName)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(resource: ColorResource.ypBlack)
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        fetchOAuthToken(code) { [weak self] result in
            assert(Thread.isMainThread)
            guard let self else { return }
            vc.dismiss(animated: true)
            
            switch result {
            case .success(let token):
                self.delegate?.didAuthenticate(self)
            case .failure(let error):
                // TODO handle an error
                print(error.localizedDescription)
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
}

extension AuthViewController {
    private func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        authService.fetchOAuthToken(code: code) { result in
            completion(result)
        }
    }
}
