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
    
  struct propertyKey {
    static let nameKey = "name"
    static let colorKey = "color"
  }
  
  init(name: String, color: UIColor) {
    self.color = color
    self.name = name
    super.init()
  }
  
  // MARK: NSCoding
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: propertyKey.nameKey)
    aCoder.encodeObject(color, forKey: propertyKey.colorKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    guard let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as? String,
          let color = aDecoder.decodeObjectForKey(propertyKey.colorKey) as? UIColor
      else { return nil }
    self.init(name: name, color: color)
  }
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("topics")
}
