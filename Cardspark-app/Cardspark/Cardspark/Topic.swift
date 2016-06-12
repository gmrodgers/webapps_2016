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
  var colour: String
  var quiz: Quiz
    
  struct propertyKey {
    static let idKey = "id"
    static let nameKey = "name"
    static let colourKey = "colour"
    static let quizKey = "quiz"
  }
  
  init(name: String, colour: String) {
    self.name = name
    self.colour = colour
    self.quiz = Quiz(name: name)
    super.init()
  }
    
  func setId(id: Int) {
    self.id = id
  }
  
  // MARK: NSCoding
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: propertyKey.nameKey)
    aCoder.encodeObject(colour, forKey: propertyKey.colourKey)
    aCoder.encodeObject(quiz, forKey: propertyKey.quizKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as? String,
          let colour = aDecoder.decodeObjectForKey(propertyKey.colourKey) as? String,
//          let quiz = aDecoder.decodeObjectForKey(propertyKey.quizKey) as? Quiz,
          let id = aDecoder.decodeObjectForKey(propertyKey.idKey) as? Int
      else { return nil }
    self.init(name: name, colour: colour)
//    self.addQuiz(Quiz(name: name))
    self.setId(id)
  }
  
  // MARK: Archiving Paths
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("topics")
}
