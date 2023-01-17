//
//  ImageInfo.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import Foundation

/// Model object for parsing image info from json.
struct ImageInfo: Codable {
    var albumId: Int
    var id: Int
    var url: URL
    var thumbnailUrl: URL
}
