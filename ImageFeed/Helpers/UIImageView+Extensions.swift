//
//  UIImageView+Extensions.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 05.04.2026.
//

import UIKit

extension UIImageView {
    func layerSetShapeCircle() {
        layer.cornerRadius = frame.size.height / 2.0;
        layer.masksToBounds = true;
    }
}
