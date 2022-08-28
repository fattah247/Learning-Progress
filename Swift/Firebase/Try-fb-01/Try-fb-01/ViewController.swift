//
//  ViewController.swift
//  Try-fb-01
//
//  Created by Muhammad Abdul Fattah on 27/08/22.
//

import UIKit
import Firebase

class ViewController: UIViewController {

  var refArtists: firdata
  
  @IBOutlet weak var textFieldName: UITextField!
  @IBOutlet weak var textFieldGenre: UITextField!
  
  @IBOutlet weak var buttonAddArtist: UIButton!
  @IBOutlet weak var labelMessage: UILabel!
  
  @IBAction func buttonAddArtist(_ sender: Any) {
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

