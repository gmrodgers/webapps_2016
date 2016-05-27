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
  struct propertyKey {
    static let nameKey = "name"
  }
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  // MARK: NSCoding
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: propertyKey.nameKey)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as! String
    
    self.init(name: name)
  }
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("topics")
}
