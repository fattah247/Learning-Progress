//
//  ShoppingList.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 03/09/22.
//

import Foundation
typealias JSONDictionary = [String:Any]

class ShoppingList : Codable{
  
  var title: String!
  var groceryItems: [GroceryItem] = [GroceryItem]()
  
  init(title: String){
    self.title = title
  }
  //MARK: - Initializer that Shopping list need, to be used in ShoppingListTableViewController
  init?(_ dictionary: [String:Any]){
    
    //Checking if the title (key) is string.
    guard let title = dictionary["title"] as? String else{
      return nil
    }
    //IF it's string and exist, the key will be set the title to itself
    self.title = title
    //To check (just like above), if dictionary exist
    let groceryItemsDictionary = dictionary["groceryItems"] as? [JSONDictionary]
    //JSONDictionary is just a dictoniary type, but we rename it.
    
    //Unwraping the dictionaries
    if let dictionaries = groceryItemsDictionary{
      self.groceryItems = dictionaries.compactMap(GroceryItem.init)
      /*
       We go through on each grocery Items, and call the initializer we made on GroceryItem.
       So we make the initiliazer on GroceryItem Model
       -> We use compactMap, because the flatMap method just exist in selection, sequences.
       -> Dictionary would use compactMap Method.
       */
    }
  }
  
  //to convert object into dictionary representation
  //+ as any
//  func toDictionary() -> [String:Any]{
//    return ["title":self.title as Any, "groceryItems":self.groceryItems.map {groceryItem in
//      return groceryItem.toDictionary()
//    }]
//  }
}
