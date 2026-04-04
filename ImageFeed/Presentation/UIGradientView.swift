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
    
    /*
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
     */
     
    /*
     override class var layerClass: AnyClass { CAGradientLayer.self }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let gradient = self.layer as? CAGradientLayer else { return }
        
        isOpaque = false
        
        //if let gradient = self.layer as? CAGradientLayer
        //{
        gradient.startPoint = .init(x: 0.5, y: 0) //CGPoint.zero
        gradient.endPoint = .init(x: 0.5, y: 1) //CGPoint(x: 0, y: bounds.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        //}
    }
     */
}
