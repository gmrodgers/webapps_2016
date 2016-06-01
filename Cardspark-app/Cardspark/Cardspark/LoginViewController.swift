
//
//  LoginViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 22/05/16.
//  Copyright (c) 2016 Mango Productions. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  override func viewDidAppear(animated: Bool) {
    if let user = FIRAuth.auth()?.currentUser {
      self.login(user)
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.endEditing(true)
    return false
  }
  
  // MARK: Login
  @IBAction func didClickLogin(sender: AnyObject) {
    FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!) { (user, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      self.login(user!)
    }
  }
  
  @IBAction func didTapSignUp(sender: AnyObject) {
    let email = emailTextField.text
    let password = passwordTextField.text
    FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      let alert = UIAlertController.init(title: "",
                                         message: "New user has been created",
                                         preferredStyle: .Alert)
      alert.addAction(UIAlertAction.init(title: "OK",
                                          style: UIAlertActionStyle.Default,
                                          handler: { action in
                                            self.setDisplayName(user!)
                                          }))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  @IBAction func didRequestPasswordReset(sender: AnyObject) {
    let alert = UIAlertController(title: "",
                                  message: "Mate, you are going to need to sort this out with Google",
                                  preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK",
                                  style: UIAlertActionStyle.Default,
                                  handler: nil))
    presentViewController(alert, animated: true, completion: nil)
  }


  func setDisplayName(user: FIRUser) {
    let changeRequest = user.profileChangeRequest()
    changeRequest.displayName = user.email!.componentsSeparatedByString("@")[0]
    changeRequest.commitChangesWithCompletion(){ (error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      self.login(FIRAuth.auth()?.currentUser)
    }
  }
  
  func login(user: FIRUser?) {
    FIRAnalytics.logEventWithName(kFIREventLogin, parameters: nil)
    
    AppState.sharedInstance.displayName = user!.email!.componentsSeparatedByString("@")[0]
    AppState.sharedInstance.signedIn = true
    AppState.sharedInstance.userID = user!.uid
    
    NSNotificationCenter.defaultCenter().postNotificationName("onSignInCompleted", object: nil, userInfo: nil)
    performSegueWithIdentifier("SignIn", sender: nil)
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
