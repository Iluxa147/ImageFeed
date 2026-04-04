//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 30.03.2026.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    // MARK: - State
    
    static let reuseIdentifier = "ImagesListCell"
    
    private enum ConstantsInner {
        static let gradientBottomHeight: CGFloat = 30
        static let gradientBottomColors = [UIColor.fullTransparent.cgColor, UIColor.ypBlack.cgColor]
        static let likeOnImageName = "Like button on"
        static let likeOffImageName = "Like button off"
    }
    
    private var gradientLayerBottom = CAGradientLayer()
    
    // MARK: - UI
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Public members
    func configure(image: UIImage, date: String, isLiked: Bool) {
        cellImage.image = image
        dateLabel.text = date
        
        gradientLayerBottom.frame = CGRect(
            x: 0,
            y: bounds.height - ConstantsInner.gradientBottomHeight,
            width: bounds.width,
            height: ConstantsInner.gradientBottomHeight)
        gradientLayerBottom.colors = ConstantsInner.gradientBottomColors
        cellImage.layer.addSublayer(gradientLayerBottom)
        
        let likeImage = isLiked ?
        UIImage(named: ConstantsInner.likeOnImageName) :
        UIImage(named: ConstantsInner.likeOffImageName)
        likeButton.setImage(likeImage, for: .normal)
    }
}
