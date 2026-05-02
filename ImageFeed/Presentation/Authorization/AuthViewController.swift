//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 29.04.2026.
//

import UIKit

final class AuthViewController: UIViewController {
    // MARK: - State
    private enum ConstantsInner {
        static let buttonAuthorizeText = "Войти"
        static let buttonNavBackBlackName = "button_nav_back_black"
    }
    
    private static let showWebViewSegueIdentifier = "ShowWebView"
    
    // MARK: - UI
    //private var buttonAuthorize: UIButton?
    @IBOutlet private weak var buttonAuthorize: UIButton!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAuthorize.layer.cornerRadius = 16
        configureBackButton()
        
        //uiAddLogoUnsplash()
        //uiAddButtonAuthorize()
    }
    
    // MARK: - Actions

    @IBAction func buttonAuthorizeDidTap(_ sender: UIButton) {
        print("AZAZA buttonAuthorizeDidTap")
    }
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: ConstantsInner.buttonNavBackBlackName)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: ConstantsInner.buttonNavBackBlackName)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(resource: ColorResource.ypBlack)
    }
    
    //@objc
    //private func buttonAuthorizeDidTap() {
    //    //print("AZAZA buttonAuthorizeDidTap")
    //}
}

/*
 private extension AuthViewController {
 // MARK: - UI Initial
 
 private func uiAddLogoUnsplash() {
 let imageLogo = UIImage(named: AppUiConstants.logoUnsplash)
 let imageViewLogo = UIImageView(image: imageLogo)
 
 imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
 view.addSubview(imageViewLogo)
 NSLayoutConstraint.activate([
 imageViewLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
 imageViewLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 280),
 imageViewLogo.heightAnchor.constraint(equalToConstant: 60),
 imageViewLogo.widthAnchor.constraint(equalToConstant: 60),
 ])
 }
 
 private func uiAddButtonAuthorize() {
 buttonAuthorize = UIButton(type: .system)
 guard let buttonAuthorize else { return }
 
 buttonAuthorize.addTarget(self, action: #selector(self.buttonAuthorizeDidTap), for: .touchUpInside)
 buttonAuthorize.backgroundColor = UIColor(resource: ColorResource.ypWhite)
 buttonAuthorize.layer.cornerRadius = 16
 
 buttonAuthorize.setTitle(ConstantsInner.buttonAuthorizeText, for: .normal)
 buttonAuthorize.setTitleColor(UIColor(resource: ColorResource.ypBlack), for: .normal)
 buttonAuthorize.titleLabel?.font = UIFont(name: AppUiConstants.fontBold, size: AppUiConstants.fontSizeMedium)
 
 buttonAuthorize.translatesAutoresizingMaskIntoConstraints = false
 view.addSubview(buttonAuthorize)
 NSLayoutConstraint.activate([
 buttonAuthorize.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
 buttonAuthorize.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
 buttonAuthorize.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -124),
 buttonAuthorize.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
 buttonAuthorize.heightAnchor.constraint(equalToConstant: 48),
 ])
 }
 }
 */
