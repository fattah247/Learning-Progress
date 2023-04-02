//
//  String+Extensions.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 18/09/22.
//

import Foundation

extension String{
  
  func removeSpecialCharacters() -> String{
    
    return self.components(separatedBy: CharacterSet.letters.inverted).joined()
  }
}
