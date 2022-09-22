//
//  FiltersService.swift
//  2-CameraFilter
//
//  Created by Muhammad Abdul Fattah on 22/09/22.
//

import Foundation
import UIKit
import CoreImage

class FiltersService {
  
  private var context: CIContext
  
  init() {
    self.context = CIContext()
  }
  
  func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
    
    let filter = CIFilter(name: "CICMYKHalftone")!
    filter.setValue(5.0, forKey: kCIInputWidthKey)
    
    if let sourceImage = CIImage(image: inputImage) {
      
      filter.setValue(sourceImage, forKey: kCIInputImageKey)
      
      if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
        
        let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        completion(processedImage)
      }
    }
  }
}
