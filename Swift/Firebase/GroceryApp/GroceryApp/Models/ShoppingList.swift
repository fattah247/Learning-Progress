//
//  ShoppingList.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 03/09/22.
//

import Foundation
typealias JSONDictionary = [String:Any]

class ShoppingList{
  
  var title: String!
  var groceryItems: [GroceryItem] = [GroceryItem]()
  
  init(title: String){
    self.title = title
  }
  
  init?(_ dictionary:[String:Any]){
    guard let title = dictionary["title"] as? String else{
      return nil
    }
    
    self.title = title
    let groceryItemsDictionary = dictionary["groceryItems"] as? [JSONDictionary]
    
    if let dictionaries = groceryItemsDictionary{
      self.groceryItems = dictionaries.compactMap(GroceryItem.init)
    }
  }
  
  //to convert object into dictionary representation
  
  func toDictionary() -> [String:Any]{
    return ["title":self.title]
    
  }
}
