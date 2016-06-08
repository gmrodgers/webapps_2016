//
//  Quiz.swift
//  Cardspark
//
//  Created by Leanne Lyons on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Quiz: NSObject {
  
  var name: String
  var quiz: [(question: Question, answers: Answers)] = []
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  func addToQuiz(new: (question: Question, answers: Answers)) {
    quiz.append(new)
  }
  
  class Question: NSObject {
    var question: String
    
    init(question: String) {
      self.question = question
      super.init()
    }
  }
  
  class Answers: NSObject {
    var answers = [String]()
    
    func addAnswer(answer: String) {
      self.answers.append(answer)
    }
    
    func deleteAnswer(id: Int) {
      self.answers.removeAtIndex(id)
    }
    
    func getNumAnswers() -> Int {
      return answers.count
    }
  }
}
