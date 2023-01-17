//
//  ImageListViewModel.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Protocol used for commucation with controller.
protocol ImageListViewModelDelegate: AnyObject {
    func reloadItems()
    func displayAlert(alert: UIAlertController)
}

/// Manages a list of thumbnail images loaded from a list of urls.
class ImageListViewModel {
    // url for image list
    let imageListUrl = "https://jsonplaceholder.typicode.com/photos"
    // responsible for fetching images
    var imageProvider: ImageProvider
    // list of images to display
    var imageList: [ImageInfo] = []
    // image list view controller
    weak var delegate: ImageListViewModelDelegate?
    
    static func defaultViewModel() -> ImageListViewModel {
        let network = SessionNetwork()
        let imageProvider = ImageProviderLogger(imageProvider: WebImageProvider(network: network, cache: DiskDataCache()))
        return ImageListViewModel(imageProvider: imageProvider)
    }
    
    init(imageProvider: ImageProvider) {
        self.imageProvider = imageProvider
        getImageList()
    }
    
    func sectionCount() -> Int {
        return 1
    }
    
    func itemCount(for section: Int) -> Int {
        return imageList.count
    }
    
    func imageInfo(for indexPath: IndexPath) -> ImageInfo {
        return imageList[indexPath.row]
    }
    
    func configure(cell: inout ImageCollectionViewCell, in collectionView: UICollectionView, at indexPath: IndexPath) {
        let info = imageInfo(for: indexPath)
        cell.configure(imageInfo: info, imageProvider: imageProvider)
    }
    
    func getImageList() {
        let session = SessionNetwork()
        session.fetch(from: URL(string: imageListUrl)!) { [weak self] data in
            let decoder = JSONDecoder()
            if let data = data,
                let list = try? decoder.decode([ImageInfo].self, from: data) {
                print("\(list.count) image list items downloaded")
                self?.imageList = list
                DispatchQueue.main.async {
                    self?.delegate?.reloadItems()
                }
            }
            else {
                let alert = UIAlertController(title: "Photos", message: "Could not download images", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self?.delegate?.displayAlert(alert: alert)
            }
        }
    }
}

