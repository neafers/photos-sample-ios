//
//  ImageViewModel.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Protocol used for commucation with controller.
protocol ImageViewModelDelegate: AnyObject {
    func imageLoaded(image: UIImage)
}

/// Downloads and manages selected image.
class ImageViewModel {
    
    // responsible for fetching image
    var imageProvider: ImageProvider
    // imageInfo for image
    var imageInfo: ImageInfo?
    // delegate for download
    weak var delegate: ImageViewModelDelegate?
    
    static func defaultViewModel() -> ImageViewModel {
        let network = SessionNetwork()
        let imageProvider = ImageProviderLogger(imageProvider: WebImageProvider(network: network, cache: DiskDataCache()))
        return ImageViewModel(imageProvider: imageProvider)
    }
    
    init(imageProvider: ImageProvider) {
        self.imageProvider = imageProvider
    }
    
    func loadImage() {
        guard let imageInfo = imageInfo else { return }
        imageProvider.image(url: imageInfo.url, completion: { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.delegate?.imageLoaded(image: image)
            }
        })
    }
}
