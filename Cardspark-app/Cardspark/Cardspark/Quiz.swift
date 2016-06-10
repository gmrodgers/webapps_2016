//
//  Quiz.swift
//  Cardspark
//
//  Created by Leanne Lyons on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Quiz: NSObject {
  
  static let sharedInstance = Quiz(name: (AppState.sharedInstance.topic?.name)!)
  
  var name: String
  var quiz = [String: String]()
  
  init(name: String) {
    self.name = name
    quiz = [:]
    super.init()
  }
}
