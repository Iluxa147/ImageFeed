//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 06.04.2026.
//

import UIKit

final class SingleImageViewController: UIViewController {
    weak var imageSplash: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            uiInitSplashImage()
        }
    }
    
    // MARK: - UI
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageViewSplash: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        
        uiInitSplashImage()
    }
    
    // MARK: - Actions
    
    @IBAction private func buttonBackTouchUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonShareTouchUp(_ sender: Any) {
        guard let imageSplash else { return }
        let shareViewController = UIActivityViewController(
            activityItems: [imageSplash],
            applicationActivities: nil,
        )
        shareViewController.overrideUserInterfaceStyle = .dark
        present(shareViewController, animated: true, completion: nil)
    }
    
    // MARK: - Private members
    
    private func uiInitSplashImage() {
        guard let imageSplash else { return }
        imageViewSplash.image = imageSplash
        imageViewSplash.frame.size = imageSplash.size
        rescaleAndCenterImageInScrollView(image: imageSplash)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
}

// MARK: - UIScrollViewDelegate
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageViewSplash
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let insetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let insetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: 0, right: 0)
        scrollView.layoutIfNeeded()
    }
}
