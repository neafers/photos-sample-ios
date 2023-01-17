//
//  Network.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import Foundation

/// A simple network interface.
protocol Network {
    func fetch(from url: URL?, completion: @escaping (Data?) -> Void)
}
