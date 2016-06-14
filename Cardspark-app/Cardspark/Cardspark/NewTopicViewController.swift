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
  
  @IBOutlet weak var colourControl: ColourControl!
  
  var topic: Topic?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topicTextField.delegate = self
    checkValidTopicName()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: UITextFieldDelegate
  func checkValidTopicName() {
    let text = topicTextField.text ?? ""
    saveButton.enabled = !text.isEmpty
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
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
      let colour = getColour(colourControl.colour)
      self.topic = Topic(name: topicName, colour: colour)
    }
  }
  
  func getColour(colour : UIColor) -> String {
    switch colour {
    case UIColor.redColor() : return "red"
    case UIColor.blueColor() : return "blue"
    case UIColor.orangeColor() : return "orange"
    case UIColor.greenColor() : return "green"
    case UIColor.purpleColor() : return "purple"
    default : return "white"
    }
  }
  
  @IBAction func cancel(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
