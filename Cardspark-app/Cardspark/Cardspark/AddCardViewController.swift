//
//  AddCardViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var topicId = Int()
  @IBOutlet weak var colourControl: ColourControl!
  
  @IBOutlet weak var titleTextField: UITextView!
  @IBOutlet weak var point1TextField: UITextView!
  @IBOutlet weak var point2TextField: UITextView!
  @IBOutlet weak var point3TextField: UITextView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var image: UIImageView!
  
//  var questions: [Question] = []
  
  let COMMENTS_LIMIT = 140
    
  @IBOutlet weak var scrollView: UIScrollView!
  
  var photoImageView : UIImage?
  var imgLoc = String()
  var card: Card?
  
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if saveButton === sender {
      let colour = getColour(colourControl.colour)
      var textColor : String
      if colour == "white" {
        textColor = "black"
      } else {
        textColor = "white"
      }
      var html: String = "<style>body{background-color:\(colour);}</style>"
      html += "<h1 style='color:\(textColor)'><font face ='verdana'>\(titleTextField.text)</font></h1>"
      html += "<center><img src='\(titleTextField.text).png' height='200' width='200'><center>"
      html += "<p style='color:\(textColor)'><font size='3' face='verdana'>\(point1TextField.text)</font></p>"
      html += "<p style='color:\(textColor)'><font size='3' face='verdana'>\(point2TextField.text)</font></p>"
      html += "<p style='color:\(textColor)'><font size='3' face='verdana'>\(point3TextField.text)</font></p>"
     
      //    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
      
      card = Card(name: titleTextField.text)
      card?.topic_id = topicId
      card?.htmlData = html
      //    do {
      //      try html.writeToFile("\(documentsPath)/\(titleTextField.text).html", atomically: true, encoding: NSUTF8StringEncoding)
      //    } catch {
      //      print("Write to file failed!")
      //    }
      //
      //    print("saved")
      //   
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
  
  
  @IBAction func dissmissAddCard(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    point1TextField.delegate = self
    point2TextField.delegate = self
    point3TextField.delegate = self
  }
  
  override func viewDidAppear(animated: Bool) {
    self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    self.tabBarController?.tabBar.hidden = false
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
    image.image = photoImageView
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
      
      let question = alertController.textFields![0].text! as String
      let answer = alertController.textFields![1].text! as String
      
//      Quiz.sharedInstance.quiz[question] = answer
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
