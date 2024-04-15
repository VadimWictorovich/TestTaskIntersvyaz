//
//  GalleryImageCollectionVC.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import UIKit


final class GalleryPhotosCollectionVC: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private var photos: [PhotoModel]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }


    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else { return  UICollectionViewCell() }
        let photo = photos?[indexPath.row]
        cell.thumbnailUrl = photo?.thumbnailUrl
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos?[indexPath.row]
        
    }
    
    private func fetchPhotos() {
        NetworkService.fetchPhotos { [weak self] result, error in
            if let error { 
                print(error)
            } else if let result, let self {
                self.photos = photos
                self.collectionView.reloadData()
            }
        }
    }
}
