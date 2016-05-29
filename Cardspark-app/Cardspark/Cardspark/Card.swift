//
//  Card.swift
//  Cardspark
//
//  Created by Martin Xu on 29/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class Card: NSObject {
    
    var name = String()
    
    var url = NSURL()
    
    init(name: String, url: NSURL){
        self.name = name
        self.url = url
    }

}
