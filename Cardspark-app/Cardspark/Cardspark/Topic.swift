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
  var id: Int?
  var name: String
  var color: UIColor
  var quiz: Quiz
    
  struct propertyKey {
    static let idKey = "id"
    static let nameKey = "name"
    static let colorKey = "color"
    static let quizKey = "quiz"
  }
  
  init(name: String, color: UIColor) {
    self.name = name
    self.color = color
    self.quiz = Quiz(name: name)
    super.init()
  }
    
  convenience init(name: String) {
    self.init(name: name, color: AppState.sharedInstance.color)
  }
  
//  func addQuiz(quiz: Quiz) {
//    self.quiz = quiz
//  }
  
  func setId(id: Int) {
    self.id = id
  }
  
  // MARK: NSCoding
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: propertyKey.nameKey)
    aCoder.encodeObject(color, forKey: propertyKey.colorKey)
    aCoder.encodeObject(quiz, forKey: propertyKey.quizKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as? String,
          let color = aDecoder.decodeObjectForKey(propertyKey.colorKey) as? UIColor,
//          let quiz = aDecoder.decodeObjectForKey(propertyKey.quizKey) as? Quiz,
          let id = aDecoder.decodeObjectForKey(propertyKey.idKey) as? Int
      else { return nil }
    self.init(name: name, color: color)
//    self.addQuiz(Quiz(name: name))
    self.setId(id)
  }
  
  // MARK: Archiving Paths
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("topics")
}
