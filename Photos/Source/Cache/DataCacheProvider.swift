//
//  DataCacheProvider.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import Foundation

typealias CacheCompletion = (() -> Void)?

/// Defines an interface for objects to provide caching behavior for Data objects.
protocol DataCacheProvider {
    func cache(data: Data, named: String, completion: CacheCompletion)
    func cachedData(named: String) -> Data?
}
