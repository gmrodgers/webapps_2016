//
//  ColourPickerViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 04/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class ColourPickerViewController: UIViewController {
  
  @IBOutlet weak var colourControl: ColourControl!
  
  var topicColor : UIColor = UIColor.whiteColor()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "addColor" {
      topicColor = colourControl.color!
      print ("picker \(topicColor)")
    }
  }
}
