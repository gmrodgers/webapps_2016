//
//  Card.swift
//  Cardspark
//
//  Created by Martin Xu on 29/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Card: NSObject {
  
  var id: Int?
  var name = String()
  var topic_id = Int()
  var htmlData = String()
  var url = NSURL()
  
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
