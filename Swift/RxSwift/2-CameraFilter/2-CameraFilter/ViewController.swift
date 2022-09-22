//
//  ViewController.swift
//  2-CameraFilter
//
//  Created by Muhammad Abdul Fattah on 21/09/22.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var applyFilterButton: UIButton!
  
  //To Dispose Subscription, so we have less memory leaks
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
   
  }
  
  //MARK: - Prepare Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    /*
     Navigation controller is the destination for the Segue,
     And it will be casted to UINavigationController
     */
    guard let navC = segue.destination as? UINavigationController,
          //After knowing the destination, we could get photoCollectionViewController.
          let photoCVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Segue destination is not found")
    }
    
    //Subscription to selectedPhoto
    photoCVC.selectedPhoto
      .subscribe(onNext: { [weak self] photo in
        //Using onNext, so we get the actual image
        
        //assigned to ImageViewControl
//        self?.photoImageView.image = photo
        //The '?' and [weak self] are used, so the var is not atteched to, and will be okay if there is no return
        
        DispatchQueue.main.async {
          self?.updateUI(with: photo)
        }
        
      }).disposed(by: disposeBag)
  }
  
  @IBAction func applyFilterButtonPressed() {
    
    guard let sourceImage = self.photoImageView.image else{
      return
    }
    
    FiltersService().applyFilter(to: sourceImage) { filteredImage in
      
      DispatchQueue.main.async {
        self.photoImageView.image = filteredImage
      }
    }
  }
  
  private func updateUI(with image: UIImage) {
    self.photoImageView.image = image
    self.applyFilterButton.isHidden = false
  }


}

