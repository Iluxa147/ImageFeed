//
//  GradientView.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 30.03.2026.
//

import UIKit

@IBDesignable
class UIGradientView: UIView {
    @IBInspectable open var startColor: UIColor = .red
    @IBInspectable open var endColor: UIColor = .green
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let colors = [startColor.cgColor, endColor.cgColor]
        
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations)
        else { return }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
    }
}
