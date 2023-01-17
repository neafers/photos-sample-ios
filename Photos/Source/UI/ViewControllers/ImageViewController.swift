//
//  ImageViewController.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Displays an image loaded from a url.
class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: ImageViewModel = .defaultViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadImage()
    }
}

extension ImageViewController: ImageViewModelDelegate {
    func imageLoaded(image: UIImage) {
        imageView.image = image
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
