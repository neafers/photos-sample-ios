//
//  MockImageListViewModelDelegate.swift
//  PhotosTests
//
//  Created by jeff on 11/8/20.
//

import UIKit
@testable import Photos

class MockImageListViewModelDelegate: ImageListViewModelDelegate {

    var reloadItemsWasCalled: Bool = false
    
    func reloadItems() {
        reloadItemsWasCalled = true
    }
    
    func displayAlert(alert: UIAlertController) {
        
    }
}
