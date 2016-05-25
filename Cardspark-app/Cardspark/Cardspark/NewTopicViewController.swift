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
  @IBOutlet weak var photoImageView: UIImageView!
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
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    checkValidTopicName()
    navigationItem.title = topicTextField.text
  }
  
  // MARK: Actions
  
  @IBAction func selectPhotoFromLibary(sender: UITapGestureRecognizer) {
    // Hide the keyboard
    topicTextField.resignFirstResponder()
    
    let imagePickerController = UIImagePickerController()
    
    imagePickerController.sourceType = .PhotoLibrary
    
    // Make sure TopicsViewController is notified when the user picks an image.
    imagePickerController.delegate = self
    
    presentViewController(imagePickerController, animated: true, completion: nil)
    
  }
  
  // MARK: UIImagePickerControllerDelegate
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    // Set photoImageView to display the selected image.
    photoImageView.image = selectedImage
    
    // Dismiss the picker.
    dismissViewControllerAnimated(true, completion: nil)
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if saveButton === sender {
      let topicName = topicTextField.text ?? ""
      topic = Topic(name: topicName)
    }
  }

  @IBAction func cancel(sender: UIBarButtonItem) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}
