//
//  ColourPickerViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 04/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class ColourPickerViewController: UIViewController {

  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  @IBOutlet weak var displayLabel: UILabel!
  
  var redColour : Float = 0
  var greenColour : Float = 0
  var blueColour : Float = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func redSliderAction(sender: UISlider) {
    changeColours()
  }

  @IBAction func greenSliderAction(sender: UISlider) {
    changeColours()
  }
  @IBAction func blueSliderAction(sender: AnyObject) {
    changeColours()
  }
  
  func changeColours() {
    redColour = redSlider.value
    greenColour = greenSlider.value
    blueColour = blueSlider.value
    changeDisplayColour()
  }
  
  func changeDisplayColour() {
    displayLabel.backgroundColor = UIColor(red: CGFloat(redColour), green: CGFloat(greenColour), blue: CGFloat(blueColour), alpha: 1.0)
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
