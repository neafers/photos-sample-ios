//
//  WebImageProvider.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

typealias ImageDownloadCompletion = (UIImage?) -> Void

/// An image provider that fetches from a remote network resource provider.
class WebImageProvider: ImageProvider {

    var cache: DataCacheProvider?
    let network: Network
    
    var activeDownloads: [String: [ImageDownloadCompletion]] = [:]
    
    init(network: Network, cache: DataCacheProvider? = nil) {
        self.cache = cache
        self.network = network
    }
    
    func image(path: String?, completion: @escaping ImageDownloadCompletion) {
        guard let path = path, let url = URL.init(string: path) else {
            return completion(nil)
        }
        
        image(url: url, completion: completion)
    }
    
    func image(url: URL?, completion: @escaping ImageDownloadCompletion) {
        guard let url = url else {
            return completion(nil)
        }
        
        let cacheName = url.path.replacingOccurrences(of: "/", with: "")
        
        // do we have a cached result? if so use it
        if let cached = cache?.cachedData(named: cacheName), let image = UIImage(data: cached) {
            return completion(image)
        }
        
        guard !activeDownloads.keys.contains(cacheName) else {
            activeDownloads[cacheName]?.append(completion)
            return
        }
        
        // setup the queue for any duplicate downloads
        activeDownloads[cacheName] = []
        
        // otherwise load from the web
        network.fetch(from: url) { [weak self] data in
            
            guard let data = data, let image = UIImage(data: data) else {
                self?.processCompletions(for: cacheName, image: nil)
                return completion(nil)
            }
            
            // add this result to cache
            self?.cache?.cache(data: data, named: cacheName, completion: nil)
            
            // and run the initial completion
            completion(image)
        }
    }
    
    private func processCompletions(for name: String, image: UIImage?) {
        // stop tracking this download
        guard let queued = activeDownloads[name] else {
            return
        }
        
        // reset queue
        activeDownloads.removeValue(forKey: name)
        
        // process completions
        for completion in queued {
            completion(image)
        }
    }
}

