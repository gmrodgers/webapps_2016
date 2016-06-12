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
  
  var quiz : [String:String] = [:]
  var question = String()
  var ansIndex = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    quiz = Quiz.sharedInstance.quiz
    pickQuestion()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func pickQuestion() {
    if quiz.count < answerButtons.count {
      qLabel.text = "ADD MORE QUESTIONS"
    }
    else {
      var answers = Array(quiz.values)
      // Get random question and corresponding answer
      question =  Array(quiz.keys)[random() % quiz.count]
      let answer = quiz[question]!
      
      qLabel.text = question
      
      ansIndex = random() % answerButtons.count
      answerButtons[ansIndex].setTitle(answer, forState: UIControlState.Normal)
      
      for i in 0..<answerButtons.count {
        answerButtons[i].tintColor = UIColor(hue: 0.4, saturation: 0.66, brightness: 0.66, alpha: 1)
        if (i == ansIndex) {
          continue
        }
        var wrongAnswer: String
        repeat {
          let wIndex = random() % answers.count
          wrongAnswer = answers[wIndex]
          answers.removeAtIndex(wIndex)
          answerButtons[i].setTitle(wrongAnswer, forState: UIControlState.Normal)
        } while (wrongAnswer == answer)
      }
    }
  }


  @IBAction func button1(sender: UIButton) {
    if ansIndex == 0 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  
  @IBAction func button2(sender: UIButton) {
    if ansIndex == 1 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button3(sender: UIButton) {
    if ansIndex == 2 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button4(sender: UIButton) {
    if ansIndex == 3 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }
  @IBAction func button5(sender: UIButton) {
    if ansIndex == 4 {
      pickQuestion()
    } else {
      sender.tintColor = UIColor.redColor()
    }
  }

}