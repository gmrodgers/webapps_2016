//
//  NewTopicViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 24/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
  
  // MARK: Properties
  @IBOutlet weak var topicTextField: UITextField!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var colorButton: UIButton!
  
  var topic: Topic?
  var topicColor: String?
  

  override func viewDidLoad() {
    super.viewDidLoad()
    topicTextField.delegate = self
    checkValidTopicName()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
    // MARK: UITextFieldDelegate
  func checkValidTopicName() {
    let text = topicTextField.text ?? ""
    saveButton.enabled = !text.isEmpty
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    // Hide the keyboard
    topicTextField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    saveButton.enabled = false
    topicTextField.selectedTextRange = self.topicTextField.textRangeFromPosition(self.topicTextField.beginningOfDocument, toPosition: self.topicTextField.endOfDocument)
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    checkValidTopicName()
    navigationItem.title = topicTextField.text
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if saveButton === sender {
      let topicName = topicTextField.text ?? ""
      self.topic = Topic(name: topicName, colour: topicColor!)
    }
  }
  
  @IBAction func addColor(segue:UIStoryboardSegue) {
    if let colourPickerViewController = segue.sourceViewController as? ColourPickerViewController {
      print (colourPickerViewController.topicColor)
      switch colourPickerViewController.topicColor {
      case UIColor.redColor() : topicColor = "red"
        break
      case UIColor.blueColor() : topicColor = "blue"
        break
      case UIColor.orangeColor() : topicColor = "orange"
        break
      case UIColor.greenColor() : topicColor = "green"
        break
      case UIColor.purpleColor() : topicColor = "purple"
        break
      default :
        topicColor = "white"
        break
      }
    }
  }
  
  @IBAction func cancel(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
