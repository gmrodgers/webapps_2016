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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  // MARK: Login

  @IBAction func createAccount(sender: AnyObject) {
    FIRAuth.auth()?.createUserWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: {
      user, error in
      if error != nil {
        self.login()
      } else {
        print ("User Created")
        self.login()
      }
    })
    
  }
  
  func login() {
    FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: {
      user, error in
      if error != nil {
        let alert  = UIAlertController(title: "Incorrect Details Enterred", message: "Please try again", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
      } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewControllerWithIdentifier("TabBar") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = tabBar
      }
    })
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
