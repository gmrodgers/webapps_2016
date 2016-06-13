//
//  Card.swift
//  Cardspark
//
//  Created by Martin Xu on 29/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit
import FirebaseStorage

class Card: NSObject {
  
  // MARK: Properties
  
  var id: Int?
  var name = String()
  var topic_id = Int()
  var htmlData = String()
  var imageRef = String()
  var imageAdded = false
  var url = NSURL()
  var question = String()
  var answer = String()
  
  // MARK: Initialisation
  
  init(name: String, url: NSURL){
    self.name = name
    self.url = url
  }
  
  convenience init(name: String) {
    self.init(name: name, url: NSURL())
  }
  
  func setId(id: Int) {
    self.id = id
  }
  
}
