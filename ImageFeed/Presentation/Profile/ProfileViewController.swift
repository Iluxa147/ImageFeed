//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 05.04.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - UI
    @IBOutlet private weak var viewAvatar: UIImageView!
    @IBOutlet private weak var buttonLogout: UIButton!
    @IBOutlet private weak var labelUserName: UILabel!
    @IBOutlet private weak var labelUserTag: UILabel!
    @IBOutlet private weak var labelUserStatus: UILabel!
    
    // MARK: - Actions
    @IBAction private func buttonLogoutTouchUp() {
        
    }
    
    
    // MARK: - State
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAvatar.layerSetShapeCircle()
    }
}
