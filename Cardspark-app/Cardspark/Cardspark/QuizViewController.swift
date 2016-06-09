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
  
  var quiz : Quiz?
  var questions = String()
  var question = String()
  
  override func viewDidLoad() {
//    quiz = Quiz.sharedInstance
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    pickQuestion()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func pickQuestion() {
    if quiz!.sizeOfQuiz() <= 4 {
      qLabel.text = "ADD MORE QUESTIONS"
    }
    else {
      let index = random() % quiz!.sizeOfQuiz()
      question =  Array(quiz!.getQuiz().values)[index]
      qLabel.text = question
      
      answerButtons[random() % answerButtons.count].setTitle(quiz!.getValue(question), forState: UIControlState.Normal)
      
      for i in 0..<answerButtons.count {
        if (answerButtons[i].titleLabel == "") {
          let index = random() % quiz!.sizeOfQuiz()
          let answer =  Array(quiz!.getQuiz().values)[index]
          answerButtons[i].setTitle(answer, forState: UIControlState.Normal)
        }
        answerButtons[i].tintColor = UIColor(hue: 0.4, saturation: 0.66, brightness: 0.66, alpha: 1)
      }
    }
  }
  
  @IBAction func button1(sender: UIButton) {
    if sender.titleLabel == question {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  
  @IBAction func button2(sender: UIButton) {
    if sender.titleLabel == question {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button3(sender: UIButton) {
    if sender.titleLabel == question {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button4(sender: UIButton) {
    if sender.titleLabel == question {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button5(sender: UIButton) {
    if sender.titleLabel == question {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
}
