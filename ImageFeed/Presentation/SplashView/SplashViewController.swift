//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 03.05.2026.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let showAuthViewSegueIdentifier = "ShowAuthView"
        static let tabBarViewIdentifier = "TabBarViewController"
    }
    private let tokenStorage = OAuth2TokenStorage.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if tokenStorage.token != nil {
            switchToTabBarController()
        } else {
            performSegue(withIdentifier: Constants.showAuthViewSegueIdentifier, sender: nil)
        }
    }
    
    // MARK: - Navigation
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: Constants.tabBarViewIdentifier)
        
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        switchToTabBarController()
    }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.showAuthViewSegueIdentifier else {
            super.prepare(for: segue, sender: sender)
            return
        }
        
        guard
            let navigationController = segue.destination as? UINavigationController,
            let authViewController = navigationController.viewControllers.first as? AuthViewController else {
            assertionFailure("Failed to prepare for segue \(Constants.showAuthViewSegueIdentifier)")
            return
        }
        
        authViewController.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
