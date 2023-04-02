//
//  Article.swift
//  3-NewsAppMVVM
//
//  Created by Muhammad Abdul Fattah on 25/09/22.
//

import Foundation

struct ArticleResponse: Decodable {
  let articles: [Article]
}

struct Article: Decodable {
  let title: String
  let description: String?
}
