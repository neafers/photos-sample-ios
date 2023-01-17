//
//  FileManager+Paths.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import Foundation

// Extension providing convenience functions for accessing common urls
extension FileManager {
    
    static let imageCacheDirectoryName = "SM"
    
    static func imageCacheURL() -> URL? {
        guard let path = FileManager.cachesDirectory() else {
            print("Unable to find caches directory path...")
            return nil
        }
        
        let url = URL(fileURLWithPath: path, isDirectory: true).appendingPathComponent(imageCacheDirectoryName, isDirectory: true)
        createDirectory(url: url)
        
        return url
    }
    
    static func cachesDirectory() -> String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    static func createDirectory(url: URL) {
        if url.absoluteString.hasPrefix("file://") {
            createDirectory(filepath: url.relativePath)
        } else {
            createDirectory(filepath: url.absoluteString)
        }
    }
    
    class func createDirectory(filepath: String) {
        var isDirectory: ObjCBool = true
        guard FileManager.default.fileExists(atPath: filepath, isDirectory: &isDirectory) == false else {
            return
        }
        
        do {
            try FileManager.default.createDirectory(atPath: filepath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error: \(error) creating directory at path: \(filepath) -")
        }
    }
}
