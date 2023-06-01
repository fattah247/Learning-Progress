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
import FirebaseAuth

class ShoppingListTableViewController: UITableViewController, AddShoppingListTableViewControllerDelegate{
  
  private var shoppingLists = [ShoppingList]()
  //Database reference
  private var rootRef: DatabaseReference!
  //To access user
  let user: User = Auth.auth().currentUser!
  
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    //Referencing to database
    self.rootRef = Database.database().reference()
    //The title size
    self.navigationController?.navigationBar.prefersLargeTitles = true
    //Populating the data in database
    populateShoppingLists()
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
      let shoppingList = self.shoppingLists[indexPath.row]
      let shoppingListRef = self.rootRef.child(shoppingList.title)
      shoppingListRef.removeValue()
    }
  }
  
  //MARK: - To populate data from Firebase
  private func populateShoppingLists(){
    
    //MARK: Observing
    /*
    -> Observing type of an event, any change in data will be observed
    -> Without the "Child", the "snapshot" will contain the root
    -> Child would make it observes specifcally on the child of user.
     */
    self.rootRef.child(self.user.emailWithoutSpecialCharacters).observe(.value){snapshot in
      
      //After getting the snapshot, it will remove all view, before add the updated one
      self.shoppingLists.removeAll()
      
      //Container of the the snapshot
      let shoppingListDictionary = snapshot.value as? [String:Any] ?? [:]
      /*
       To go through the key inside the dictionary,
       and once we inside of the dict, we look for the actual key.
       
       -> Snapshot represents the value or the node at a certain point in time.
       */
      for (key, _) in shoppingListDictionary{
        /*
         Already inside of the dictionary,
         Now here, we want to contain the actual key (in form of dictionary)
         */
        if let shoppingListDictionary = shoppingListDictionary[key] as? [String:Any]{
          
          if let shoppingList = ShoppingList(shoppingListDictionary){
            /*Need initiaizer on ShoppingList Class (to check if the title is string),
             before appending to global Variable.
             */
            self.shoppingLists.append(shoppingList)
          }
        }
      }
      
      //Dispatch will make sure the function reload will happen in main thread or UI thread
      DispatchQueue.main.async {
        //Reloading the tableView data
        self.tableView.reloadData()
      }
    }
  }
  
  //MARK: - When canceling additional Shopping list
  func addShoppingListTableViewControllerDidCancel(controller: UIViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  //MARK: When saving additional Shopping list
  func addShoppingListTableViewControllerDidSave(controller: UIViewController, title: String) {
    print(title)
    //To get the title of added shopping list
    let shoppingList = ShoppingList(title: title)
    //To add it to local variable
    self.shoppingLists.append(shoppingList)
    
    let userRef = self.rootRef.child(self.user.emailWithoutSpecialCharacters)
    
    //MARK: adding to Firebase
    //Giving reference
    let shoppingListRef = userRef.child(shoppingList.title)
    //Make a node with dictionary
    shoppingListRef.setValue(try! shoppingList.toDictionary())
    
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
  
  //MARK: - To prepare segue to grocery page (inside of the Shop list)
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