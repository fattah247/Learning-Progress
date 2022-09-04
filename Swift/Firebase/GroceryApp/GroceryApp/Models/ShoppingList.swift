//
//  ShoppingList.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 03/09/22.
//

import Foundation

class ShoppingList{
  var title: String!
  var groceryItems: [GroceryItem] = [GroceryItem]()
  
  init(title: String){
    self.title = title 
  }
}
