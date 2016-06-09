//
//  Quiz.swift
//  Cardspark
//
//  Created by Leanne Lyons on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Quiz: NSObject {
  
//  static let sharedInstance = Quiz()
  
  var name: String
  var quiz = [String: String]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  func addToQuiz(question: String, answer: String) {
    quiz[question] = answer
  }
  
  func sizeOfQuiz() -> Int {
    return quiz.count
  }
  
  func getQuiz() -> [String: String] {
    return quiz
  }
  
  func getValue(question: String) -> String {
    return quiz[question]!
  }

}
