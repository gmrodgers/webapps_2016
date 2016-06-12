//
//  ViewCardViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 01/06/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class ViewCardViewController: UIViewController {
  
  var cards = [Card]()
  var index = Int()
  
  @IBAction func prevCard(sender: AnyObject) {
    if index < cards.count-1{
      index = index+1
      webview.loadHTMLString(cards[index].htmlData, baseURL: nil)
    }
    else{
      print("index too high")
    }
    
  }
  
  
  @IBAction func nextCard(sender: AnyObject) {
    if index > 0{
      index = index-1
      webview.loadHTMLString(cards[index].htmlData, baseURL: nil)
    }
  }
  
  @IBOutlet weak var webview: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
    self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
    self.tabBarController?.tabBar.hidden = true
    webview.loadHTMLString(cards[index].htmlData, baseURL: nil)
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
