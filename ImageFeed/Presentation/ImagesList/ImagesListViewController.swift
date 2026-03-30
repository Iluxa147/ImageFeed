//
//  ViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 30.03.2026.
//

import UIKit

final class ImagesListViewController: UIViewController {
    // MARK: - UI
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - State
    let photosNames: [String] = Array(0..<20).map{ "\($0)" }
    let likeOnImageName = "Like button on"
    let likeOffImageName = "Like button off"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.rowHeight = 200
        //tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

