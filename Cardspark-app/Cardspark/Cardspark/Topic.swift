//
//  Topic.swift
//  Cardspark
//
//  Created by Leanne Lyons on 24/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Topic: NSObject, NSCoding {
  
  // MARK: Properties
  
  var name: String
  var color: UIColor
  var questions: [Question]
    
  struct propertyKey {
    static let nameKey = "name"
    static let colorKey = "color"
    static let questionKey = "question"
  }
  
  init(name: String, color: UIColor, questions: [Question]) {
    self.color = color
    self.name = name
    self.questions = questions
    super.init()
  }
  
  func getQuestions() -> [Question] {
    return self.questions
  }
  
  // MARK: NSCoding
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: propertyKey.nameKey)
    aCoder.encodeObject(color, forKey: propertyKey.colorKey)
    aCoder.encodeObject(questions, forKey: propertyKey.questionKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as? String,
          let color = aDecoder.decodeObjectForKey(propertyKey.colorKey) as? UIColor,
          let questions = aDecoder.decodeObjectForKey(propertyKey.questionKey) as? [Question]
      else { return nil }
    self.init(name: name, color: color, questions: questions)
  }
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("topics")
}
