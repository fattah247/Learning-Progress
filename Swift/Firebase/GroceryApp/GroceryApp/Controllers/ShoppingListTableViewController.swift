//
//  ShoppingListTableViewController.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore

class ShoppingListTableViewController: UITableViewController, AddShoppingListTableViewControllerDelegate{
  
  private var shoppingLists = [ShoppingList]()
  
  //Database reference
  private var rootRef: DatabaseReference!
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    //Referencing to database
    self.rootRef = Database.database().reference()
    //The title size
    self.navigationController?.navigationBar.prefersLargeTitles = true
    //Populating the data in database
    populateShoppingLists()
    
  }
  
  private func populateShoppingLists(){
    
    //Observing type of an event, any change in data will be observed
    //snapshot will contain the root
    self.rootRef.observe(.value){snapshot in
      
      //After getting the snapshot, it will remove all view, before add the updated one
      self.shoppingLists.removeAll()
      
      let shoppingListDictionary = snapshot.value as? [String:Any] ?? [:]
      
      for (key, _) in shoppingListDictionary{
        
        if let shoppingListDictionary = shoppingListDictionary[key] as? [String:Any]{
          
          if let shoppingList = ShoppingList(shoppingListDictionary){
            self.shoppingLists.append(shoppingList)
          }
        }
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
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
    
    //adding to Firebase
    
    //Giving reference
    let shoppingListRef = self.rootRef.child(shoppingList.title)
    //Make a node with dictionary
    shoppingListRef.setValue(shoppingList.toDictionary())
    
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
