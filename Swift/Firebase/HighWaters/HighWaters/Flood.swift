//
//  Flood.swift
//  HighWaters
//
//  Created by Muhammad Abdul Fattah on 30/08/22.
//

import Foundation

struct Flood{
  var latitude: Double
  var longitude: Double
  
  
  func toDictionary() -> [String:Any]{
    return ["latitude":self.latitude, "longitude":self.longitude]
  }
}

extension Flood{
  init?(dictionary: [String:Any]){
    guard let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double else {
      return nil
    }
    self.latitude = latitude
    self.longitude = longitude
  }
}
