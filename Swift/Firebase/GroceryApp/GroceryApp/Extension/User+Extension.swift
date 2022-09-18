//
//  User+Extension.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 16/09/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension User{
  var emailWithoutSpecialCharacters: String{
    guard let email = self.email else{
      fatalError("Unable to access email at the moment")
    }
    
    return email.removeSpecialCharacters()
    
  }
}
