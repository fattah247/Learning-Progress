//
//  LoginTableViewController.swift
//  GroceryApp
//
//  Created by Muhammad Abdul Fattah on 01/09/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

enum AlertType : String{
  case error = "Error"
  case message = "Success"
}

class LoginTableViewController: UITableView{
  
  @IBOutlet weak var loginEmailTextField: UITextField!
  @IBOutlet weak var loginPasswordTextField: UITextField!
  
  @IBOutlet weak var registrationEmailTextField: UITextField!
  @IBOutlet weak var registrationPasswordTextField: UITextField!
  
  
  @IBAction func loginButtonPressed(){
    
  }
  @IBAction func registerButtonPressed(){
    guard let email = self.registrationEmailTextField.text,
          let password = self.registrationPasswordTextField.text else{
      return
    }
    
    Auth.auth().createUser(withEmail: email, password: password){ user, error in
      if let error = error{
        self.showAlert(with: error.localizedDescription, alertType: .error)
      } else{
        self.showAlert(with: "You are registered!", alertType: .message)
      }
      
    }
  }
  
  //Alert if it's success
  private func showAlert(with message: String, alertType: AlertType){
    
    let alertController = UIAlertController(title: alertType.rawValue, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
    
  }
  
}
