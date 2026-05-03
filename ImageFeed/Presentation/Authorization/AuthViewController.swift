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
    // MARK: - State
    private enum ConstantsInner {
        static let buttonAuthorizeText = "Войти"
        static let buttonNavBackBlackName = "button_nav_back_black"
        static let buttonNavBackWhiteName = "button_nav_back_white"
        static let showWebViewSegueIdentifier = "ShowWebView"
    }
    private let authService = OAuth2Service.shared
    
    weak var delegate: AuthViewControllerDelegate?
    
    // MARK: - UI
    @IBOutlet private weak var buttonAuthorize: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AZAZ AuthView did load")
        
        buttonAuthorize.layer.cornerRadius = 16
        configureBackButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    // MARK: - Actions
    //@IBAction func buttonAuthorizeDidTap(_ sender: UIButton) {
    //    print("AZAZA buttonAuthorizeDidTap")
    //}
}

extension AuthViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ConstantsInner.showWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else {
                assertionFailure("Failed to prepare for segue \(ConstantsInner.showWebViewSegueIdentifier)")
                return
            }
            webViewViewController.wkNavDelegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - UI Initialization
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: ConstantsInner.buttonNavBackWhiteName)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: ConstantsInner.buttonNavBackWhiteName)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(resource: ColorResource.ypBlack)
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        //assert(Thread.isMainThread)
        print("AZAZ web del 1")
        //vc.dismiss(animated: true)
        
        fetchOAuthToken(code) { [weak self] result in
            assert(Thread.isMainThread)
            guard let self else {
                print("AZAZ self 2 is nil")
                return
            }
            vc.dismiss(animated: true)
            print("AZAZ check 1")
            
            switch result {
            case .success(let token):
                //print("Auth token get succeed \(token)")
                self.delegate?.didAuthenticate(self)
            case .failure(let error):
                // TODO handle error further
                //print("Auth token get failed with error \(error)")
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
            //guard self != nil else {
            //    print("AZAZ self 1 is nil")
            //    return
            //}
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
