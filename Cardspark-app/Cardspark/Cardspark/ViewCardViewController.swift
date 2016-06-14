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
    if index < cards.count-1 {
      index = index+1
      addImageToHTMLIfPresent(cards[index])
      webview.loadHTMLString(cards[index].htmlData, baseURL: nil)
    }
    else{
      print("index too high")
    }
    
  }
  
  
  @IBAction func nextCard(sender: AnyObject) {
    if index > 0 {
      index = index-1
      addImageToHTMLIfPresent(cards[index])
      webview.loadHTMLString(cards[index].htmlData, baseURL: nil)
    }
  }
  
  @IBOutlet weak var webview: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
    self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
    self.tabBarController?.tabBar.hidden = true
    addImageToHTMLIfPresent(cards[index])
    webview.loadHTMLString(cards[index].htmlData, baseURL: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func addImageToHTMLIfPresent(card: Card) {
    if (!card.imageRef.isEmpty && !card.imageAdded) {      
      let documentDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
      let imagesURL = documentDirectoryURL.URLByAppendingPathComponent(card.imageRef)
      let fileExists = imagesURL.checkResourceIsReachableAndReturnError(nil)
      if (!fileExists) {
        do {
          try NSFileManager.defaultManager().createDirectoryAtPath(imagesURL.path!, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
          print(error.localizedDescription);
        }
      }
      let localURL = imagesURL
      let getImageRef = AppState.sharedInstance.storageRef?.child(card.imageRef)
      _ = getImageRef!.writeToFile(localURL) { (URL, error) -> Void in
        if (error != nil) {
          print("Image could not be downloaded")
          print(error.debugDescription)
        } else {
          print("Image obtained")
          card.htmlData += "<center><img src='\(localURL)' height='200' width='200'><center>"
          card.imageAdded = true
          self.webview.loadHTMLString(self.cards[self.index].htmlData, baseURL: nil)
        }
      }
    }
  }
}
