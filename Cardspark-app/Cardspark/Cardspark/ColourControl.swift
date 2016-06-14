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
  var buttonPressed = -1 {
    didSet{
      setNeedsLayout()
    }
  }
  
  let col1 = UIColor.redColor()
  let col2 = UIColor.blueColor()
  let col3 = UIColor.greenColor()
  let col4 = UIColor.orangeColor()
  let col5 = UIColor.purpleColor()
  
  var colorButtons = [UIButton]()
  var colorArray = [UIColor]()
  let spacing = 5
  let buttonCount = 5
  var colour = UIColor.whiteColor()
  
  // MARK: Initialisation
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    colorArray = [col1, col2, col3, col4, col5]
    
    for i in 0..<buttonCount {
      let button = UIButton()
      button.backgroundColor = colorArray[i]
      button.adjustsImageWhenHighlighted = false
      button.addTarget(self, action: #selector(ColourControl.colourButtonTapped(_:)), forControlEvents: .TouchDown)
      colorButtons += [button]
      addSubview(button)
    }
  }
  
  override func layoutSubviews() {
    let buttonSize = Int(frame.size.height)
    var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
    
    for (index, button) in colorButtons.enumerate() {
      buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing) + spacing)
      button.frame = buttonFrame
    }
    updateButtonSelectionStates()
  }
  
  override func intrinsicContentSize() -> CGSize {
    let buttonSize = Int(frame.size.height)
    let width = (buttonSize * buttonCount) + (spacing * (buttonCount - 1))
    return CGSize(width: width, height: buttonSize)
  }
  
  func updateButtonSelectionStates() {
    for (index, button) in colorButtons.enumerate() {
      button.selected = index == buttonPressed
      if button.selected {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackColor().CGColor
      } else {
        button.layer.borderWidth = 0
      }
    }
  }
  
  // MARK: Button Action
  func colourButtonTapped(button: UIButton) {
    buttonPressed = colorButtons.indexOf(button)!
    colour = button.backgroundColor!
    updateButtonSelectionStates()
  }
}
