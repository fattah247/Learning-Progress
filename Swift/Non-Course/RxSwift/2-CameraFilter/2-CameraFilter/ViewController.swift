//
//  ViewController.swift
//  2-CameraFilter
//
//  Created by Muhammad Abdul Fattah on 21/09/22.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
  
  //For the image
  @IBOutlet weak var photoImageView: UIImageView!
  //To apply filter
  @IBOutlet weak var applyFilterButton: UIButton!
  //To Dispose Subscription, so we have less memory leaks
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  //MARK: - Prepare Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    guard let navC = segue.destination as? UINavigationController,
          /*
           Navigation controller is the destination for the Segue,
           And it will be casted to UINavigationController
           */

          let photoCVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Segue destination is not found")
      //After knowing the destination, we could get photoCollectionViewController.
    }
    
    //Subscription to selectedPhoto
    photoCVC.selectedPhoto
    
    //Using onNext, so we get the actual image
      .subscribe(onNext: { [weak self] photo in

        //assigned to ImageViewControl
//        self?.photoImageView.image = photo
        

        DispatchQueue.main.async {
          self?.updateUI(with: photo)
        }
        /*
         The form is changed, so we just call the updateUI() function
         An also, it's now using DispatchQueue, so it knows that it will be excuted on the main thread
         
         The '?' and [weak self] are used, so the var is not atteched to, and will be okay if there is no return
         */
        
      }).disposed(by: disposeBag)
  }
  
  //MARK: - Action if the button Pressed
  @IBAction func applyFilterButtonPressed() {
    
    guard let sourceImage = self.photoImageView.image else{
      return
    }
    
    //Using the FilterService()
    //MARK: Using Subscription
    FiltersService().applyFilter(to: sourceImage)
      .subscribe(onNext: { filteredImage in
        
        DispatchQueue.main.async {
          self.photoImageView.image = filteredImage
        }
      }).disposed(by: disposeBag)
  }
  
  //MARK: - To Update UI & Pass the image
  private func updateUI(with image: UIImage) {
    self.photoImageView.image = image
    
    //To show up the button
    self.applyFilterButton.isHidden = false
  }


}

