//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 03/09/22.
//

import Foundation

class GroceryItem{
  
  var title: String!
  
  init(title: String){
    self.title = title
  }
  init?(dictionary:JSONDictionary){
    
    guard let title = dictionary["title"] as? String else{
      return nil
    }
    
    self.title = title 
  }
  
  func toDictionary() -> [String:Any]{
    return ["title":self.title]
  }
}
