//
//  Flood.swift
//  HighWaters
//
//  Created by Muhammad Abdul Fattah on 30/08/22.
//

import Foundation


//MARK: - Will represent Flood Object

//So when we add things, we could just add dictionary with key value pairs, and give that information to firebase
struct Flood{
  var latitude: Double
  var longitude: Double
  
  //Change struct into dictionary
  func toDictionary() -> [String:Any]{
    return ["latitude":self.latitude, "longitude":self.longitude]
  }
}


extension Flood{
  init?(dictionary: [String:Any]){
    
    //State the format
    guard let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double else {
      //Returning the Nil if it fails
      return nil
    }
    self.latitude = latitude
    self.longitude = longitude
  }
}
