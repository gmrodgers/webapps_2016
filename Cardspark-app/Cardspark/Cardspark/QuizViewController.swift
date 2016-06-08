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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
//    questions = Quiz.sharedInstance.questions
    pickQuestion()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func pickQuestion() {
    if questions.count <= 4 {
      qLabel.text = "ADD MORE QUESTIONS"
    }
    else {
      qNumber = random() % questions.count
      qLabel.text = questions[qNumber].question
      
      for i in 0..<answerButtons.count {
        if i == qNumber {
          answerButtons[i].setTitle(questions[qNumber].answer, forState: UIControlState.Normal)
        } else {
          let ranAns = random() % questions.count
          answerButtons[i].setTitle(questions[ranAns].answer, forState: UIControlState.Normal)
        }
        answerButtons[i].tintColor = UIColor(hue: 0.4, saturation: 0.66, brightness: 0.66, alpha: 1)
      }
    }
  }
  
  @IBAction func button1(sender: UIButton) {
    if qNumber == 0 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  
  @IBAction func button2(sender: UIButton) {
    if qNumber == 1 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button3(sender: UIButton) {
    if qNumber == 2 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button4(sender: UIButton) {
    if qNumber == 3 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button5(sender: UIButton) {
    if qNumber == 4 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
}
