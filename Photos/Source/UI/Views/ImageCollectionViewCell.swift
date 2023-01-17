//
//  ImageCollectionViewCell.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Collection view cell for downloading and displaying am image.
class ImageCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "ImageCollectionViewCell"
    
    @IBOutlet weak var oopsImageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var oopsContainerView: UIView!
    
    var imageInfo: ImageInfo?
    weak var imageProvider: ImageProvider?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    func configure(imageInfo: ImageInfo, imageProvider: ImageProvider?) {
        self.imageProvider = imageProvider
        self.imageInfo = imageInfo
        
        // start with the footer hidden
        footerView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        imageProvider?.image(url: imageInfo.thumbnailUrl, completion: { [weak self] image in
            
            DispatchQueue.main.async {
                // only set this if a new image info has not been set
                guard let myUrl = self?.imageInfo?.thumbnailUrl, myUrl == imageInfo.thumbnailUrl else {
                    return
                }
                
                // stop activity indicator
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
                
                // set the image
                self?.imageView.image = image
                
                // show oops if the image failed to load
                self?.oopsContainerView.isHidden = image != nil
                
                // and show the footer if needed
                if image != nil {
                    self?.infoLabel.text = imageInfo.thumbnailUrl.lastPathComponent
                }
            }
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // clear image view
        imageView.image = nil
        
        // hide activity indicator
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        // hide oops
        oopsContainerView.isHidden = true
    }
}
