//
//  QuizViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
  
  @IBOutlet weak var qLabel: UILabel!
  @IBOutlet var answerButtons: [UIButton]!
  
  var questions = [Question]()
  var qNumber = Int()
  var aNumber = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    questions = Quiz.sharedInstance.questions
//    pickQuestion()
  }
  
  override func viewDidAppear(animated: Bool) {
    questions = Quiz.sharedInstance.questions
    pickQuestion()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func pickQuestion() {
    if questions.count > 0 {
      qNumber = random() % questions.count
      qLabel.text = questions[qNumber].question
      aNumber = questions[qNumber].answer
      
      for i in 0..<answerButtons.count {
        answerButtons[i].setTitle(questions[qNumber].answers[i], forState: UIControlState.Normal)
      }
      
      questions.removeAtIndex(qNumber)
    } else {
      NSLog("done")
    }
  }
  
  @IBAction func button1(sender: UIButton) {
    if aNumber == 0 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  
  @IBAction func button2(sender: UIButton) {
    if aNumber == 1 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button3(sender: UIButton) {
    if aNumber == 2 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button4(sender: UIButton) {
    if aNumber == 3 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button5(sender: UIButton) {
    if aNumber == 4 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
}
