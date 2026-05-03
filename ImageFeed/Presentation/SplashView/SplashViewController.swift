//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 03.05.2026.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - State
    private enum ConstantsInner {
        static let showAuthViewSegueIdentifier = "ShowAuthView"
        static let tabBarViewIdentifier = "TabBarViewController"
    }
    private let tokenStorage = OAuth2TokenStorage.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AZAZ splash did load")
        
        //setNeedsStatusBarAppearanceUpdate()
        //uiAddAppIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //tokenStorage.removeT()
        print("AZAZ token from st \(tokenStorage.token)")
        if tokenStorage.token != nil {
            print("AZAZ Using auth token from storage \(tokenStorage.token)")
            //performSegue(withIdentifier: ConstantsInner.showAuthViewSegueIdentifier, sender: nil)

            switchToTabBarController()
        } else {
            print("AZAZ go to auth")
            performSegue(withIdentifier: ConstantsInner.showAuthViewSegueIdentifier, sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("AZAZ splash willDisappear")
    }
    
    // MARK: - Navigation
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: ConstantsInner.tabBarViewIdentifier)
        
        window.rootViewController = tabBarController
    }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ConstantsInner.showAuthViewSegueIdentifier {
            print("AZAZ splash prepare 1")
            guard
                let navigationController = segue.destination as? UINavigationController,
                let authViewController = navigationController.viewControllers.first as? AuthViewController
            else {
                print("AZAZ splash prepare 2")
                assertionFailure("Failed to prepare for segue \(ConstantsInner.showAuthViewSegueIdentifier)")
                return
            }
            print("AZAZ splash prepare 3")
            authViewController.delegate = self
        } else {
            print("AZAZ splash prepare 4")
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - UI Initialization
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func uiAddAppIcon() {
        let imageAppLogo = UIImage(named: AppUiConstants.appIcon)
        let imageViewAppLogo = UIImageView(image: imageAppLogo)
        
        imageViewAppLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageViewAppLogo)
        NSLayoutConstraint.activate([
            imageViewAppLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageViewAppLogo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            imageViewAppLogo.heightAnchor.constraint(equalToConstant: 75),
            imageViewAppLogo.widthAnchor.constraint(equalToConstant: 72),
        ])
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func didAuthenticate(_ vc: AuthViewController) {
        print("AZAZA didAuthenticate")
        vc.dismiss(animated: true)
        switchToTabBarController()
    }
}
