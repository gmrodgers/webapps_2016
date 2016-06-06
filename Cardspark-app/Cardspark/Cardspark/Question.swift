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
  var answer : String!
//  var answer: Int!
  
  init(question : String!, answer : String!) {
    self.question = question
    self.answer = answer
  }
}
