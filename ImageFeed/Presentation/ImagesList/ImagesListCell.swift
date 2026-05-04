//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 30.03.2026.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    private var gradientLayerBottom = CAGradientLayer()
    
    // MARK: - Constants
    static let reuseIdentifier = "ImagesListCell"
    private enum Constants {
        static let gradientBottomHeight: CGFloat = 30
        static let gradientBottomColors = [UIColor.fullTransparent.cgColor, UIColor.ypBlack.cgColor]
        static let likeOnImageName = "Like button on"
        static let likeOffImageName = "Like button off"
    }
    
    // MARK: - Public members
    func configure(image: UIImage, date: String, isLiked: Bool) {
        cellImage.image = image
        dateLabel.text = date
        
        gradientLayerBottom.frame = CGRect(
            x: 0,
            y: bounds.height - Constants.gradientBottomHeight,
            width: bounds.width,
            height: Constants.gradientBottomHeight)
        gradientLayerBottom.colors = Constants.gradientBottomColors
        cellImage.layer.addSublayer(gradientLayerBottom)
        
        let likeImage = isLiked ?
        UIImage(named: Constants.likeOnImageName) :
        UIImage(named: Constants.likeOffImageName)
        likeButton.setImage(likeImage, for: .normal)
    }
}
