//
//  MockImageProvider.swift
//  PhotosTests
//
//  Created by jeff on 11/8/20.
//

import UIKit
@testable import Photos

class MockImageProvider: ImageProvider {
    func image(path: String?, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
    }
    
    func image(url: URL?, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
    }
}
