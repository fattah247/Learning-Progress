//
//  AddShoppingListTableViewController.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

import Foundation
import UIKit

protocol AddShoppingListTableViewControllerDelegate{
  
  //To save the shopping list
  func addShoppingListTableViewControllerDidSave(controller: UIViewController, title: String)
  //To cancel
  func addShoppingListTableViewControllerDidCancel(controller: UIViewController)
}


class AddShoppingListTableViewController: UITableViewController{
  
  
  @IBOutlet weak var titleTextField: UITextField!
  var delegate: AddShoppingListTableViewControllerDelegate!
  
  @IBAction func save(){
    if let title = self.titleTextField.text{
      self.delegate.addShoppingListTableViewControllerDidSave(controller: self, title: title)
    }
  }
  
  @IBAction func cancel(){
    self.delegate.addShoppingListTableViewControllerDidCancel(controller: self)
    
  }
}
