//
//  PhotosCollectionViewController.swift
//  2-CameraFilter
//
//  Created by Muhammad Abdul Fattah on 21/09/22.
//

import Foundation
import UIKit
import RxSwift
//Framework of photos
import Photos

class PhotosCollectionViewController: UICollectionViewController{
  
  //It's a Subject in RxSwift
  private let selectedPhotoSubject = PublishSubject<UIImage>()
  //Making the subject observable, so any controller can subscribe to it
  var selectedPhoto: Observable<UIImage> {
    return selectedPhotoSubject.asObservable()
  }
  
  //Will be a collection (or placeholder) for PHAsset
  private var images = [PHAsset]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatePhotos()
  }
  
  //MARK: -
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1 // 1 becase we don't use any section
  }
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  //MARK: -
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    //To get the selected Asset
    let selectedAsset = self.images[indexPath.row]
    /*
     But it will only take the PHAsset
     But we need to get the actual Value of it
     */
    
    //Get the actual Image
    PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
      
        guard let info = info else { return }

      //Will tell either the image is degraded or not
        let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool

      //Will let the orignal image out if it's not degraded.
        if !isDegradedImage {
          if let image = image {
            self?
              .selectedPhotoSubject.onNext(image)
            self?.dismiss(animated: true, completion: nil)
          }
        }
      }
  }
    
  //Will going to be responsible for giving UICollectionViewCell
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
      }
    }
  }
}