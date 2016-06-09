//
//  AppState.swift
//  Cardspark
//
//  Created by Leanne Lyons on 30/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import Foundation
import Firebase

class AppState: NSObject {
  
  static let sharedInstance = AppState()
  
  var signedIn = false
  var displayName: String?
  var userID : String?
  var userEmail : String?
  var dataServer = DataServer()
    
  // Why is there a global colour and topic?
  var color : UIColor = UIColor.whiteColor()  
}
