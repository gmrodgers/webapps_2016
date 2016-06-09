//
//  CardTableViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
  
  var topicId = Int()
  var cards = [Card]()
  var dataServer = AppState.sharedInstance.dataServer
  
  @IBAction func dismissCards(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cards = getCards()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cards.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "CardTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardTableViewCell
    cell.cardLabel.text = cards[indexPath.row].name
    return cell
    
  }
  
  func getCards() -> [Card] {
    let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    var pdfFiles = [NSURL]()
    do {
      let directoryUrls = try  NSFileManager.defaultManager().contentsOfDirectoryAtURL(documentsUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
      pdfFiles = directoryUrls.filter{ $0.pathExtension! == "html" }
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    for file in pdfFiles {
      cards += [Card(name: file.lastPathComponent!, url: file)]
    }
    
    return cards
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      cards.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
  }
  
  @IBAction func addUser(sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Add User", message: "Enter the email address of a user you want to add", preferredStyle: UIAlertControllerStyle.Alert)
    
    let saveAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {
      alert -> Void in
      
      let email = alertController.textFields![0].text! as String
      self.dataServer.addNewTopicViewer(email, topic_id: self.topicId)
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
      (action : UIAlertAction!) -> Void in
      
    })
    
    alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
      textField.placeholder = "Email Address"
    }
    
    alertController.addAction(saveAction)
    alertController.addAction(cancelAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if  segue.identifier == "viewCardSegue",
      let destination = segue.destinationViewController as? ViewCardViewController,
      let row = tableView.indexPathForSelectedRow?.row
    {
      destination.url = cards[row].url
      destination.index = row
      destination.cards = cards
    }
  }
}
