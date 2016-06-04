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
  
  var topic: Topic?

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
      topic = Topic(name: topicName, color: AppState.sharedInstance.color!)
    }
  }

  @IBAction func cancel(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: nil)
    print("Cancel")
  }

}
