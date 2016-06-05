//
//  ColourControl.swift
//  Cardspark
//
//  Created by Leanne Lyons on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class ColourControl: UIView {
  
  // MARK: Properties
  var color = UIColor.whiteColor()
  var colorButtons = [UIButton]()
  var colorArray = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.orangeColor(), UIColor.yellowColor()]
  
  let spacing = 5
  let buttonCount = 5
  
  // MARK: Initialisation

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    for i in 0..<buttonCount {
      let button = UIButton()
      button.backgroundColor = colorArray[i]
      button.addTarget(self, action: #selector(ColourControl.colourButtonTapped(_:)), forControlEvents: .TouchDown)
      colorButtons += [button]
      addSubview(button)
    }
  }
  
  override func layoutSubviews() {
    let buttonSize = Int(frame.size.height)
    var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
    
    for (index, button) in colorButtons.enumerate() {
      buttonFrame.origin.x = CGFloat(index * (44 + spacing))
      button.frame = buttonFrame
    }
  }
  
  override func intrinsicContentSize() -> CGSize {
    let buttonSize = Int(frame.size.height)
    let width = (buttonSize * buttonCount) + (spacing * (buttonCount - 1))
    
    return CGSize(width: width, height: buttonSize)
  }
  
  // MARK: Button Action
  func colourButtonTapped(button: UIButton) {
    AppState.sharedInstance.color = button.backgroundColor
  }
  
  

}
