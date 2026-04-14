//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 05.04.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - State
    private enum ConstantsInner {
        static let profileImageNameMock = "Avatar mock"
        static let userNameMock = "Екатерина Новикова"
        static let userTagMock = "@ekaterina_nov"
        static let userStatusMock =  "Hello, world!"
        
        static let buttonLogoutImageName = "ipad.and.arrow.forward"
    }
    
    // MARK: - UI
    private weak var imageViewProfile: UIImageView?
    private weak var buttonLogout: UIButton?
    private weak var labelUserName: UILabel?
    private weak var labelUserTag: UILabel?
    private weak var labelUserStatus: UILabel?
    
    // MARK: - Actions
    
    @objc
    private func buttonLogoutDidTap() {
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiAddProfileImage()
        uiAddButtonLogout()
        uiAddLabelsProfileDesc()
    }
    
    // MARK: - UI Initial
    
    private func uiAddProfileImage() {
        let imageProfile = UIImage(named: ConstantsInner.profileImageNameMock)
        let imageViewProfile = UIImageView(image: imageProfile)
        imageViewProfile.layerSetShapeCircle()
        
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageViewProfile)
        NSLayoutConstraint.activate([
            imageViewProfile.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageViewProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 70),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 70),
        ])
        
        self.imageViewProfile = imageViewProfile
    }
    
    private func uiAddButtonLogout() {
        guard let imageViewProfile else { return }
        
        let buttonLogout = UIButton.systemButton(
            with: UIImage(systemName: ConstantsInner.buttonLogoutImageName)!,
            target: self,
            action: #selector(self.buttonLogoutDidTap)
        )
        buttonLogout.tintColor = UIColor(resource: ColorResource.ypRed)
        
        buttonLogout.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonLogout)
        NSLayoutConstraint.activate([
            buttonLogout.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonLogout.centerYAnchor.constraint(equalTo: imageViewProfile.centerYAnchor),
            buttonLogout.heightAnchor.constraint(equalToConstant: 44),
            buttonLogout.widthAnchor.constraint(equalToConstant: 44),
        ])
        
        self.buttonLogout = buttonLogout
    }
    
    private func uiAddLabelsProfileDesc() {
        guard let imageViewProfile else { return }
        
        labelUserName = uiCreateProfileLabelBase(
            text: ConstantsInner.userNameMock,
            textColor: ColorResource.ypWhite,
            fontName: AppUiConstants.fontBold,
            fontSize: AppUiConstants.fontSizeBig
        )
        
        labelUserTag = uiCreateProfileLabelBase(
            text: ConstantsInner.userTagMock,
            textColor: ColorResource.ypGray,
            fontName: AppUiConstants.fontRegular,
            fontSize: AppUiConstants.fontSizeNormal
        )
        
        labelUserStatus = uiCreateProfileLabelBase(
            text: ConstantsInner.userStatusMock,
            textColor: ColorResource.ypWhite,
            fontName: AppUiConstants.fontRegular,
            fontSize: AppUiConstants.fontSizeNormal
        )
        
        guard let labelUserName, let labelUserTag, let labelUserStatus else { return }
        
        NSLayoutConstraint.activate([
            labelUserName.topAnchor.constraint(equalTo: imageViewProfile.bottomAnchor, constant: 8),
            labelUserName.leadingAnchor.constraint(equalTo: imageViewProfile.leadingAnchor),
            
            labelUserTag.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 8),
            labelUserTag.leadingAnchor.constraint(equalTo: imageViewProfile.leadingAnchor),
            
            labelUserStatus.topAnchor.constraint(equalTo: labelUserTag.bottomAnchor, constant: 8),
            labelUserStatus.leadingAnchor.constraint(equalTo: imageViewProfile.leadingAnchor),
        ])
    }
    
    private func uiCreateProfileLabelBase(text: String, textColor: ColorResource, fontName: String, fontSize: CGFloat) -> UILabel {
        let uiLabel = UILabel()
        uiLabel.text = text
        uiLabel.textColor = UIColor(resource: textColor)
        uiLabel.font = UIFont(name: fontName, size: fontSize)
        
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uiLabel)
        
        return uiLabel
    }
}
