//
//  DiskDataCache.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import Foundation

import UIKit

/// A simple disk cache provider.
class DiskDataCache: DataCacheProvider {
    
    let queue: OperationQueue = .init()
    let cacheURL: URL? = FileManager.imageCacheURL()
    
    init() {
        queue.name = "Disc Cache Queue"
    }
    
    func cachedData(named: String) -> Data? {
        guard let url = cacheURL?.appendingPathComponent(named), let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return data
    }
    
    func cache(data: Data, named: String, completion: CacheCompletion = nil) {
        guard let url = cacheURL?.appendingPathComponent(named) else {
            return
        }
        
        let operation = BlockOperation {
            do {
                try data.write(to: url, options: [.atomicWrite])
            } catch {
                print("ERROR: Failed to write \(named) to cache: \(error)")
            }
        }
        
        operation.completionBlock = completion
        queue.addOperation(operation)
    }
}
