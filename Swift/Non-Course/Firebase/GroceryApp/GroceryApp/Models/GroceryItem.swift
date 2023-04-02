//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 03/09/22.
//

import Foundation

class GroceryItem : Codable{
  
  var title: String!
  
  init(title: String){
    self.title = title
  }
  
  //MARK: - The initializer of Grocery Item
  init?(dictionary: JSONDictionary){
    
    //The tilte here is the item name, not the shop (like cookies, etc)
    guard let title = dictionary["title"] as? String else{
      return nil
    }
    
    self.title = title 
  }
  
  //+ as any
//  func toDictionary() -> [String:Any]{
//    return ["title":self.title as Any]
//  }
}
