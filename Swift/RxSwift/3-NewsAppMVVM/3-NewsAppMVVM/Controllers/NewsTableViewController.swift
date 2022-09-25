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
  private var articleListVM: ArticleListViewModel!
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    populateNews()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articleListVM == nil ? 0:self.articleListVM.articlesVM.count
  }
  
  private func populateNews() {
    let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e8ff998012ce4e538b3405d03a01619f")!)
    
    URLRequest.load(resource: resource).subscribe(onNext: {print($0)
    }).disposed(by: disposeBag)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
      fatalError("ArticleTableViewCell is not found")
    }
    
    let articleVM = self.articleListVM.articleAt(indexPath.row)
    
    articleVM.title.asDriver(onErrorJustReturn: "")
      .drive(cell.titleLabel.rx.text)
      .disposed(by: disposeBag)
    
    articleVM.description.asDriver(onErrorJustReturn: "").drive(cell.descriptionLabel.rx.text).disposed(by: disposeBag)
    
    return cell
  }
}

