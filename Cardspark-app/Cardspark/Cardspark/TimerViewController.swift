//
//  TimerViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 26/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
  
  // MARK: Properties
  
  var counter = 60*20
  var timer = NSTimer()
  
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func startTimerButtonTapped(sender: UIButton) {
    timer.invalidate()
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
  }
  
  @IBAction func cancelTimerButtonTapped(sender: UIButton) {
    timer.invalidate()
  }
  
  func timerAction() {
    counter -= 1
    label.text = "\(counter / 60)m\(counter % 60)s"
    if counter == 0 {
      let alert = UIAlertController(title: "Timer is up!",
                                    message: "",
                                    preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Dismiss",
        style: UIAlertActionStyle.Default,
        handler: { action in self.counter = 60 * 25
      }))
      presentViewController(alert, animated: true, completion: {self.timer.invalidate()})
      
    }
  }
  
  @IBAction func resetButtonTapped(sender: UIButton) {
    timer.invalidate()
    counter = 60 * 20
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
  }
  
  @IBAction func breakButtonTapped(sender: AnyObject) {
    timer.invalidate()
    counter = 60 * 5
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
  }
}
