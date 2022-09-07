//
//  GroceryItemsTableViewController.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore

class GroceryItemsTableViewController: UITableViewController, AddGroceryItemTableViewControllerDelegate{
  
  //Variable from the storybard before is passed to this variable
  var shoppingList: ShoppingList!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //to change the title accordingly
    self.title = shoppingList.title
    //to change the large title item
    self.navigationItem.largeTitleDisplayMode = .never
  }
  
  func addGroceryItemTableViewControllerDidCancel(controller: UIViewController) {
    //To Close
    controller.dismiss(animated: true, completion: nil)
  }
  
  func addGroceryItemTableViewControllerDidSave(controller: UIViewController, groceryItem: GroceryItem) {
    
    self.shoppingList.groceryItems.append(groceryItem)
    controller.dismiss(animated: true, completion: nil)
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
      
      self.shoppingList.groceryItems.remove(at: indexPath.row)
      self.tableView.reloadData()
      
    }
  }
  
  //MARK: - Function to display table View
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.shoppingList.groceryItems.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryItemTableViewCell", for: indexPath)
    
    let groceryItem = self.shoppingList.groceryItems[indexPath.row]
    cell.textLabel?.text = groceryItem.title
    
    return cell
  }
  
  //MARK: - Prepare to do segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    guard let nc = segue.destination as? UINavigationController else{
      return
    }
    
    guard let addGroceryTVC = nc.viewControllers.first as? AddGroceryItemTableViewController else{
      return
    }
    
    addGroceryTVC.delegate = self
  }
}
 
