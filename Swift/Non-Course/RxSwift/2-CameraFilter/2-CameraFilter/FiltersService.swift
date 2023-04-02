//
//  FiltersService.swift
//  2-CameraFilter
//
//  Created by Muhammad Abdul Fattah on 22/09/22.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FiltersService {

  private var context: CIContext
  
  init() {
    self.context = CIContext()
  }
  
  //MARK: - Filter Function
  
  //MARK: Function with Observable
  func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
    //This Function will return an observable of UI Image
    return Observable<UIImage>.create { observer in
      
      //Will Call the function below
      self.applyFilter(to: inputImage) {
        filteredImage in
        
        observer.onNext(filteredImage)
      }
      return Disposables.create()
    }
  }
  
  
  //MARK: function without observable
  private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
    /*
     This Function will take argument as the input UI image, and will apply the filter on this image, then returned the the processed image.
     
     Completion is enclosure, which will get fireed once the filter has been applied.
     */
    
    //Creating Filter using CIFilter, which containt the name (can get it online)
    let filter = CIFilter(name: "CICMYKHalftone")!
    
    //Value is how intense the filter.
    filter.setValue(5.0, forKey: kCIInputWidthKey)
    
    
    if let sourceImage = CIImage(image: inputImage) {
      /*
       If we using Core image, we have to create Core Image,
       which input image will be passed into
       */
      filter.setValue(sourceImage, forKey: kCIInputImageKey)
      //KCIInputImageKey is a key that pass a flawless image.
      
      //After using the Key, we are able to use the context
      if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
        /*
         It means, we are creating the CGImage, and will get the output image
         And will give us particular context that we want.
         */
        
        let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        //Completion will send the processedImage
        completion(processedImage)
      }
    }
  }
}
