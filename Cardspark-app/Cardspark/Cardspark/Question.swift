//
//  Question.swift
//  Cardspark
//
//  Created by Leanne Lyons on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Question : NSObject {
  var question : String!
  var answers : [String]!
  var answer: Int!
  
  init(question : String!, answers : [String]!, answer: Int!) {
    self.question = question
    self.answers = answers
    self.answer = answer
  }
}
