//
//  Encodable+Extension.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 17/09/22.
//

import Foundation


extension Encodable{
  
  func toDictionary() throws -> [String:Any]{
    
    let data = try! JSONEncoder().encode(self)
    guard let dict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else{
      throw NSError()
    }
    return dict
  }
}
