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