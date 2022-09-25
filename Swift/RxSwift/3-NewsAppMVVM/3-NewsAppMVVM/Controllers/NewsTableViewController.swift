//
//  NewsTableViewController.swift
//  3-NewsAppMVVM
//
//  Created by Muhammad Abdul Fattah on 25/09/22.
//

import Foundation
import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    populateNews()
  }
  
  private func populateNews() {
    let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e8ff998012ce4e538b3405d03a01619f")!)
    
    URLRequest.load(resource: resource).subscribe(onNext: {print($0)
    }).disposed(by: disposeBag)
  }
}

