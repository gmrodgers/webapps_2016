//
//  AddCardViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var titleTextField: UITextView!
  @IBOutlet weak var point1TextField: UITextView!
  @IBOutlet weak var point2TextField: UITextView!
  @IBOutlet weak var point3TextField: UITextView!
  
  var questions: [Question] = []
  
  let COMMENTS_LIMIT = 140
    
  @IBOutlet weak var scrollView: UIScrollView!
  
  var photoImageView : UIImage?
  var imgLoc = String()
  
  // MARK: UITextViewDelegate
  func textView(textView: UITextView, shouldChangeTextInRange range:NSRange, replacementText text:String ) -> Bool {
    if text == "\n"
    {
      textView.resignFirstResponder()
    }
    return textView.text.characters.count + (text.characters.count - range.length) <= COMMENTS_LIMIT;
    
  }
  func textViewDidEndEditing(textView : UITextView) {
    scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
  }
  
  func textViewShouldReturn(textView: UITextView) -> Bool {
    textView.resignFirstResponder()
    return true
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    if textView == point3TextField {
      scrollView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
  }
  
  @IBAction func saveCard(sender: AnyObject) {
    
    var html: String = "<h2><font face ='verdana'>\(titleTextField.text)</font></h1>"
    html += "<p><font size='3' face='verdana'>\(point1TextField.text)</font></p>"
    html += "<p><font size='3' face='verdana'>\(point2TextField.text)</font></p>"
    html += "<p><font size='3' face='verdana'>\(point3TextField.text)</font></p>"
    html += "<center><img src='\(titleTextField.text).png' height='200' width='200'><center>"
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    
    try? html.writeToFile("\(documentsPath)/\(titleTextField.text).html", atomically: true, encoding: NSUTF8StringEncoding)
    
    print("saved")
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  @IBAction func dissmissAddCard(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    point1TextField.delegate = self
    point2TextField.delegate = self
    point3TextField.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func selectImageFromLibrary(sender: UIBarButtonItem) {
    
    // UIImagePickerController is a view controller that lets a user pick media from their photo library.
    let imagePickerController = UIImagePickerController()
    
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = .PhotoLibrary
    
    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self
    
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled.
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    // The info dictionary contains multiple representations of the image, and this uses the original.
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage!
    
    // Set photoImageView to display the selected image.
    photoImageView = selectedImage
    let data = UIImagePNGRepresentation(photoImageView!)
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let filename: String = "\(documentsPath[0])/\(titleTextField.text).png"
    print(filename)
    data?.writeToFile(filename, atomically: true)
    
    imgLoc = filename
    
    
    // Dismiss the picker.
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func addQuestion(sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "QUIZ", message: "Insert a question for the quiz", preferredStyle: UIAlertControllerStyle.Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
      alert -> Void in
      
//      Quiz.sharedInstance.questions += [Question(question: alertController.textFields![0].text! as String, answer: alertController.textFields![1].text! as String)]
      
      
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
      (action : UIAlertAction!) -> Void in
      
    })
    
    alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
      textField.placeholder = "Question"
    }
    alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
      textField.placeholder = "Answer"
    }
    
    alertController.addAction(saveAction)
    alertController.addAction(cancelAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
}
