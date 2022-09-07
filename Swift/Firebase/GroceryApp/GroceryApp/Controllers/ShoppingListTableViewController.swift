//
//  ShoppingListTableViewController.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore

class ShoppingListTableViewController: UITableViewController, AddShoppingListTableViewControllerDelegate{
  
  private var shoppingLists = [ShoppingList]()
  
  override func viewDidLoad(){
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func addShoppingListTableViewControllerDidCancel(controller: UIViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func addShoppingListTableViewControllerDidSave(controller: UIViewController, title: String) {
    print(title)
    
    //To get the title of added shopping list
    let shoppingList = ShoppingList(title: title)
    //To add it to local variable
    self.shoppingLists.append(shoppingList)
    
    //To close the card after save it.
    controller.dismiss(animated: true, completion: nil)
    
    //To Reload the Data
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.shoppingLists.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath)
    let shoppingList = self.shoppingLists[indexPath.row]
    cell.textLabel?.text = shoppingList.title
    return cell
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "AddShoppingListTableViewController"{
      
      let nc = segue.destination as! UINavigationController
      let addShoppingListVC = nc.viewControllers.first as! AddShoppingListTableViewController
      addShoppingListVC.delegate = self
    } else if segue.identifier == "GroceryItemsTableViewController"{
      guard let indexPath = self.tableView.indexPathForSelectedRow else{
        return
      }
      
      let groceryItemsTVC = segue.destination as! GroceryItemsTableViewController
      groceryItemsTVC.shoppingList = self.shoppingLists[indexPath.row]
    }
  }

}
