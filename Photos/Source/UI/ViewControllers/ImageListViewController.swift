//
//  ImageListViewController.swift
//  Photos
//
//  Created by jeff on 11/7/20.
//

import UIKit

/// Displays a list of thumbnail images loaded from a list of urls.
class ImageListViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: ImageListViewModel = .defaultViewModel()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.delegate = self
        configureCollectionView()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshImageList), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func configureCollectionView() {
        // configure and register our custom cell
        let cellID = ImageCollectionViewCell.cellID
        let xib = UINib(nibName: cellID, bundle: Bundle(for: ImageCollectionViewCell.self))
        collectionView.register(xib, forCellWithReuseIdentifier: cellID)
        
        // single selection for now
        collectionView.allowsMultipleSelection = false
        
        // create and configure the flow layout
        let layout = UICollectionViewFlowLayout()
        let columns: CGFloat = 3
        let spacing: CGFloat = 10
        let padding = layout.sectionInset.left + layout.sectionInset.right + spacing
        let estimatedSize = (UIScreen.main.bounds.size.width - ((spacing * 4) + padding)) / columns
        layout.itemSize = CGSize(width: estimatedSize, height: estimatedSize)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        // specify content insets
        collectionView.contentInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    @objc func refreshImageList() {
        refreshControl.beginRefreshing()
        viewModel.getImageList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue",
            let vc = segue.destination as? ImageViewController,
            let selectedImageItem = collectionView.indexPathsForSelectedItems?.first {
            vc.viewModel.imageInfo = viewModel.imageInfo(for: selectedImageItem)
        }
    }
}

extension ImageListViewController: ImageListViewModelDelegate {
    func reloadItems() {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func displayAlert(alert: UIAlertController) {
        alert.present(self, animated: true, completion: nil)
        refreshControl.endRefreshing()
    }
}

extension ImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellID, for: indexPath)
        
        if var imageCell = cell as? ImageCollectionViewCell {
            viewModel.configure(cell: &imageCell, in: collectionView, at: indexPath)
        }
        return cell
    }
}

extension ImageListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}
