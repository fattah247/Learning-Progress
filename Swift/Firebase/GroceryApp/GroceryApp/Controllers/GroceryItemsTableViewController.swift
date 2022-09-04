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

class GroceryItemsTableViewController: UITableViewController, AddGroceryItemTableViewContollerDelegate{
  
  //Variable from the storybard before is passed to this variable
  var shoppingList: ShoppingList!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //to change the title accordingly
    self.title = shoppingList.title
    //to change the large title item
    self.navigationItem.largeTitleDisplayMode = .never
  }
  
  func addGrceryItemTableViewControllerDidCancel(controller: UIViewController) {
    //To Close
    controller.dismiss(animated: true, completion: nil)
  }
  func addGroceryItemTableViewControllerDidSave(controller: UIViewController, groceryItem: GroceryItem) {
    
    self.shoppingList.groceryItems.append(groceryItem)
  }
  
  //MARK: - Function to display table View
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.shoppingList.groceryItems.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let nc = segue.destination as? UINavigationController else{
      return
    }
    
    guard let addGroceryTVC = nc.viewControllers.first as? AddGroceryItemTableViewController else{
      return
    }
  }
}
 
