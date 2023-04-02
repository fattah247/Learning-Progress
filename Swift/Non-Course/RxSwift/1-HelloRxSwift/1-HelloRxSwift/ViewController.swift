//
//  ViewController.swift
//  1-HelloRxSwift
//
//  Created by Muhammad Abdul Fattah on 21/09/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    _ = Observable.from([1,2,3,4,5])
  }


}

