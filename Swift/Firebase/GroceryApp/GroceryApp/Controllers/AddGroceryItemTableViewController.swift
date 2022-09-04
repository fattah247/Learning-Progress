//
//  AddGroceryItemTableViewController.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

import Foundation
import UIKit

protocol AddGroceryItemTableViewContollerDelegate{
  
  func addGrceryItemTableViewControllerDidCancel(controller: UIViewController)
  func addGroceryItemTableViewControllerDidSave(controller: UIViewController, groceryItem: GroceryItem)
  
}
class AddGroceryItemTableViewController: UITableViewController{
  
  @IBOutlet weak var titleTextField: UITextField!
  var delegate: AddGroceryItemTableViewContollerDelegate
  
  @IBAction func save(){
    if let title = self.titleTextField.text{
      
      let groceryItem = GroceryItem(title: title)
      self.delegate.addGroceryItemTableViewControllerDidSave(controller: self, groceryItem: groceryItem)
    }
  }
  
  @IBAction func cancel(){
    self.delegate.addGrceryItemTableViewControllerDidCancel(controller: self)
    
    
  }
}
