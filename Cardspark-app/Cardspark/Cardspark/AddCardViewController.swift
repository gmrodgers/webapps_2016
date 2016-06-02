//
//  AddCardViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var titleTextField: UITextView!
  @IBOutlet weak var point1TextField: UITextView!
  @IBOutlet weak var point2TextField: UITextView!
  @IBOutlet weak var point3TextField: UITextView!
  
  let COMMENTS_LIMIT = 140
  
  @IBOutlet weak var scrollView: UIScrollView!
  
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
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    if textView == point3TextField {
      scrollView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
  }
  
  @IBAction func saveCard(sender: AnyObject) {
    
    var html: String = "<h3><center>\(titleTextField.text)</h3></center>"
    html += "<p>\(point1TextField.text)</p>"
    html += "<p>\(point2TextField.text)</p>"
    html += "<p>\(point3TextField.text)</p>"
    
    let fmt = UIMarkupTextPrintFormatter(markupText: html)
    let render = UIPrintPageRenderer()
    render.addPrintFormatter(fmt, startingAtPageAtIndex: 0)
    let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
    let printable = CGRectInset(page, 0, 0)
    
    render.setValue(NSValue(CGRect: page), forKey: "paperRect")
    render.setValue(NSValue(CGRect: printable), forKey: "printableRect")
    
    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil)
    
    for i in 1...render.numberOfPages() {
      
      UIGraphicsBeginPDFPage();
      let bounds = UIGraphicsGetPDFContextBounds()
      render.drawPageAtIndex(i - 1, inRect: bounds)
    }
    
    UIGraphicsEndPDFContext();
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    
    pdfData.writeToFile("\(documentsPath)/\(titleTextField.text).pdf", atomically: true)
    
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
}
