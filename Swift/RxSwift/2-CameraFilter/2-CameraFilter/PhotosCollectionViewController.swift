//
//  PhotosCollectionViewController.swift
//  2-CameraFilter
//
//  Created by Muhammad Abdul Fattah on 21/09/22.
//

import Foundation
import UIKit
//Framework of photos
import Photos

class PhotosCollectionViewController: UICollectionViewController{
  
  //Will be a collection (or placeholder) for PHAsset
  private var images = [PHAsset]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatePhotos()
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { fatalError("PhotoCollectionViewCell is not found")
    }
    
    let asset = self.images[indexPath.row]
    let manager = PHImageManager.default()
    
    manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) {image, _ in
      
      DispatchQueue.main.async {
        cell.photoImageView.image = image
      }
    }
    
    return cell
    
    
    
  }
  private func populatePhotos(){
    
    //To Reqquest Authorizaation
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      /*
       [weak self] is used, because it's asynchronous operation,
       it will make sure it has no runtime cycle if there is any.
       */
      if status == .authorized{
        
        //Acces the photo from library
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        //PHAsset is built-in class,
        //PHAssetMediaType is going to set what kind of media we look for.
        
        //Enumerate will go over all the assets we have just retrieved
        assets.enumerateObjects{ (object, count, stop) in
          self?.images.append(object)
        }
        
        //To make it show the most recent ones
        self?.images.reverse()
        
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
        print(self?.images as Any)
        
        //self?.collectionView.reloadData()
      }
    }
  }
}
