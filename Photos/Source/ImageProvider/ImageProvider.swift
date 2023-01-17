//
//  ImageProvider.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Defines an interface for objects to provide images at specified paths or urls.
protocol ImageProvider: AnyObject {
    func image(path: String?, completion: @escaping (UIImage?) -> Void)
    func image(url: URL?, completion: @escaping (UIImage?) -> Void)
}
