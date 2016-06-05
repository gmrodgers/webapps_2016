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
  
  let col1 = UIColor(hue: 0, saturation: 0.66, brightness: 0.66, alpha: 1)
  let col2 = UIColor(hue: 0.2, saturation: 0.66, brightness: 0.66, alpha: 1)
  let col3 = UIColor(hue: 0.4, saturation: 0.66, brightness: 0.66, alpha: 1)
  let col4 = UIColor(hue: 0.6, saturation: 0.66, brightness: 0.66, alpha: 1)
  let col5 = UIColor(hue: 0.8, saturation: 0.66, brightness: 0.66, alpha: 1)
  
  var colorButtons = [UIButton]()
  var colorArray = [UIColor]()
  
  let spacing = 5
  let buttonCount = 5
  
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
    AppState.sharedInstance.color = button.backgroundColor!
    updateButtonSelectionStates()
  }
  
  

}
