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

class ShoppingListTableViewController: UITableViewController, AddShoppingListTableViewContollerDelegate{
  override func viewDidLoad(){
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func addShoppingListTableViewControllerDidCancel(controller: UIViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
  func addShoppingListTableViewControllerDidSave(controller: UIViewController, title: String) {
    print(title)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddShoppingListTableViewController"{
      let nc = segue.destination as! UINavigationController
      let addShoppingListVC = nc.viewControllers.first as! AddShoppingListTableViewController
      addShoppingListVC.delegate = self
    }
  }


}
