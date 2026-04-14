//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Ilya Pokolev on 06.04.2026.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var imageSplash: UIImage? {
        didSet {
            guard isViewLoaded, let imageSplash else { return }
            imageViewSplash.image = imageSplash
            imageViewSplash.frame.size = imageSplash.size
            rescaleAndCenterImageInScrollView(image: imageSplash)
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
        
        guard let imageSplash else { return }
        imageViewSplash.image = imageSplash
        imageViewSplash.frame.size = imageSplash.size
        rescaleAndCenterImageInScrollView(image: imageSplash)
    }
    
    // MARK: - Actions
    
    @IBAction private func buttonBackTouchUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonShareTouchUp(_ sender: Any) {
        guard let imageSplash else { return }
        let shareViewController = UIActivityViewController(
            activityItems: [imageSplash],
            applicationActivities: nil
        )
        present(shareViewController, animated: true, completion: nil)
    }
    
    // MARK: - Private members
    
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
        return imageViewSplash
    }
}
