//
//  AddCardViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK : Properties
  
  var topicId = Int()
  var imageData : NSData?
  let COMMENTS_LIMIT = 140
  var question = String()
  var answer = String()
  var photoImageView : UIImage?
  var imgLoc = String()
  var card: Card?
  
  
  @IBOutlet weak var colourControl: ColourControl!
  @IBOutlet weak var titleTextField: UITextView!
  @IBOutlet weak var point1TextField: UITextView!
  @IBOutlet weak var point2TextField: UITextView!
  @IBOutlet weak var point3TextField: UITextView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  // MARK: Initialisation
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    self.tabBarController?.tabBar.hidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  
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
      html += "<p style='color:\(textColor)'><font size='3' face='verdana'>\(point1TextField.text)</font></p>"
      html += "<p style='color:\(textColor)'><font size='3' face='verdana'>\(point2TextField.text)</font></p>"
      html += "<p style='color:\(textColor)'><font size='3' face='verdana'>\(point3TextField.text)</font></p>"
      
      card = Card(name: titleTextField.text)
      card?.topic_id = topicId
      card?.htmlData = html
      card?.question = question
      card?.answer = answer
      
      if ((imageData) != nil) {
        let path = "users/\(AppState.sharedInstance.userEmail!)/\(topicId)/\(titleTextField.text).png"
        let imageRef = AppState.sharedInstance.storageRef!.child(path)
        card?.imageRef = path
        print("Card image ref: \(path)")
        _ = imageRef.putData((imageData!), metadata: nil) { metadata, error in
          if (error != nil) {
            print("Image failed to upload")
          } else {
            _ = metadata!.downloadURL()
            print("saved to firebase")
          }
        }
      }
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
  
  // MARK : ImagePicker Delegate
  @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
    print ("tapped")
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .PhotoLibrary
    imagePickerController.delegate = self
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage!
    
    photoImageView = selectedImage
    image.image = photoImageView
    let data = UIImagePNGRepresentation(photoImageView!)
    imageData = data
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let filename: String = "\(documentsPath[0])/\(titleTextField.text).png"
    print(filename)
    data?.writeToFile(filename, atomically: true)
    
    imgLoc = filename
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: Quiz Alert
  @IBAction func addQuestion(sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "QUIZ", message: "Insert a question for the quiz", preferredStyle: UIAlertControllerStyle.Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
      alert -> Void in
      
      self.question = alertController.textFields![0].text! as String
      self.answer = alertController.textFields![1].text! as String
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
