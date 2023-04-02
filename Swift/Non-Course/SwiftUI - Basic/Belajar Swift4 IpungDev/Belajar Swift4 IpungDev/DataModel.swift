//
//  DataModel.swift
//  Belajar Swift4 IpungDev
//
//  Created by Muhammad Abdul Fattah on 23/07/22.
//

import Foundation

//Data Model
struct DataModel: Identifiable{
  let id: Int
  let productName: String
  let productPhoto: String
  let productPrice: Int
  let location: String
  let ratingCount: Int
  let totalRating: Int
  
  init(id: Int, productName: String, productPhoto: String,productPrice: Int, location: String, ratingCount: Int, totalRating: Int){
    
      self.id = id
      self.productName = productName
      self.productPhoto = productPhoto
      self.productPrice = productPrice
      self.location = location
      self.ratingCount = ratingCount
      self.totalRating = totalRating
    
      }
}
