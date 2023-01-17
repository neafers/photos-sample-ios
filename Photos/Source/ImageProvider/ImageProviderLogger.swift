//
//  ImageProviderLogger.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Provides logging functionality for requests passing through an ImageProvider
class ImageProviderLogger: ImageProvider {
    
    private var imageProvider: ImageProvider
    
    init(imageProvider: ImageProvider) {
        self.imageProvider = imageProvider
    }
    
    func image(path: String?, completion: @escaping (UIImage?) -> Void) {
        print("Image: \(path ?? "unknown")")
        imageProvider.image(path: path, completion: completion)
    }
    
    func image(url: URL?, completion: @escaping (UIImage?) -> Void) {
        print("Image: \(url?.absoluteString ?? "unknown")")
        imageProvider.image(url: url, completion: completion)
    }
}
