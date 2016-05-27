//
//  TimerViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 26/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
  
  var counter = 60 * 25
  var timer = NSTimer()
  
  @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
  
  // start timer
  @IBAction func startTimerButtonTapped(sender: UIButton) {
    timer.invalidate() // just in case this button is tapped multiple times
    
    // start the timer
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
  }
  
  // stop timer
  @IBAction func cancelTimerButtonTapped(sender: UIButton) {
    timer.invalidate()
  }
  
  // called every time interval from the timer
  func timerAction() {
    counter -= 1
    label.text = "\(counter / 60)m \(counter % 60)s"
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
