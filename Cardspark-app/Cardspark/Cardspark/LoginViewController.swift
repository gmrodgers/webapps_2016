//
//  LoginViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 22/05/16.
//  Copyright (c) 2016 Mango Productions. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidAppear(animated: Bool) {
    if let user = FIRAuth.auth()?.currentUser {
      self.login(user)
    }
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
      self.setDisplayName(user!)
      let _ = UIAlertController.init(title: nil, message: "New user \(user?.displayName) has been created", preferredStyle: UIAlertControllerStyle.Alert)
      let _ = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
    }
  }
  
  @IBAction func didRequestPasswordReset(sender: AnyObject) {
    let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
      let userInput = prompt.textFields![0].text
      if (userInput!.isEmpty) {
        return
      }
      FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
      }
    }
    prompt.addTextFieldWithConfigurationHandler(nil)
    prompt.addAction(okAction)
    presentViewController(prompt, animated: true, completion: nil)
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
