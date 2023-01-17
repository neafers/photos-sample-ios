//
//  SessionNetwork.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import Foundation

/// A session based network class.
class SessionNetwork: Network {
    
    let session = URLSession(configuration: .default)
    
    func fetch(from url: URL?, completion: @escaping (Data?) -> Void) {
        
        guard let url = url else {
            return completion(nil)
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let response = response as? HTTPURLResponse, let data = data else {
                print("Error downloading: \(String(describing: error))")
                return
            }
            
            print("Response code \(response.statusCode)")
            completion(data)
        }
        
        task.resume()
    }
}

