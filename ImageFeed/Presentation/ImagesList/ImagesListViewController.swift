//
//  ViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 30.03.2026.
//

import UIKit

final class ImagesListViewController: UIViewController {
    // MARK: - UI
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - State
    let photosNames = (0..<20).map(String.init)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        guard let cellImage = UIImage(named: photosNames[indexPath.row]) else { return UITableViewCell() }
        
        imageListCell.configure(
            image: cellImage,
            date: Date().dateString,
            isLiked: indexPath.row % 2 == 0)
        
        return imageListCell
    }
}

// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosNames[indexPath.row]) else {
            return 0
        }
        
        let edgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - edgeInsets.left - edgeInsets.right
        let imageWidth = image.size.width
        let ratio = imageViewWidth / imageWidth
        let cellHeight = image.size.height * ratio + edgeInsets.top + edgeInsets.bottom
        
        return cellHeight
    }
}
