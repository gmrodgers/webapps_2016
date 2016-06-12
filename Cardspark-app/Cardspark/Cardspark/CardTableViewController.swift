//
//  CardTableViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController, UISearchBarDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var topicId = Int()
  var cards = [Card]()
  var filtered = [Card]()
  var dataServer = AppState.sharedInstance.dataServer
  var newIndexPath: NSIndexPath?
  var searchActive : Bool = false
  
  
  @IBAction func dismissCards(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    
    dataServer.loadCardsList(topicId, controller: self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: SearchBar Delegate
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchActive = true
  }
  
  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    searchActive = false
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchActive = false
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchActive = false
    searchBar.resignFirstResponder()
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    filtered = cards.filter({ (card) -> Bool in
      let tmp: NSString = card.name
      let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      return range.location != NSNotFound
    })
    searchActive = !(filtered.count == 0)
    self.tableView.reloadData()
  }

  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(searchActive) {
      return filtered.count
    }
    return cards.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "CardTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardTableViewCell
    if(searchActive){
      cell.cardLabel.text = filtered[indexPath.row].name
    }
    cell.cardLabel.text = cards[indexPath.row].name
    return cell
    
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      // Delete the row from the data source
      dataServer.deleteCard((cards[indexPath.row]).id!, controller: self)
      cards.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
    }
  }
  
  @IBAction func unwindToCardsList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? AddCardViewController, card = sourceViewController.card {
      // Add a new card
      newIndexPath = NSIndexPath(forRow: cards.count, inSection: 0)
      dataServer.createNewCard(card, controller: self)
    }
  }
  
//  func getCards() -> [Card] {
//    let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
//    var pdfFiles = [NSURL]()
//    do {
//      let directoryUrls = try  NSFileManager.defaultManager().contentsOfDirectoryAtURL(documentsUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
//      pdfFiles = directoryUrls.filter{ $0.pathExtension! == "html" }
//    } catch let error as NSError {
//      print(error.localizedDescription)
//    }
//    for file in pdfFiles {
//      cards += [Card(name: file.lastPathComponent!, url: file)]
//    }
//    
//    return cards
//  }
  
  func loadCardsListHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode == 200) {
      print("status code: \(statusCode)")
      do {
        let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as!NSDictionary
        if let cards = dict.valueForKey("object") as? [[String: AnyObject]] {
          for card in cards {
            if let name = card["cardname"] as? String, id = card["id"] as? Int, htmlData = card["card_data"] as? String, topic_id = card["topic_id"] as? Int {
              let newCard = Card(name: name)
              newCard.setId(id)
              newCard.topic_id = topic_id
              newCard.htmlData = htmlData
              self.cards.append(newCard)
            }
          }
        }
      }catch {
        print("Error with Json")
      }
    }
    dispatch_async(dispatch_get_main_queue()) {
      self.tableView.reloadData()
    }
  }
  
  func createCardHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
        
    if (statusCode == 200) {
      do {
        let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as!NSDictionary
        if let card = dict.valueForKey("object") as? [String: AnyObject] {
          if let name = card["cardname"] as? String, id = card["id"] as? Int, htmlData = card["card_data"] as? String, topic_id = card["topic_id"] as? Int {
            let newCard = Card(name: name)
            newCard.setId(id)
            newCard.topic_id = topic_id
            newCard.htmlData = htmlData
            self.cards.append(newCard)
            print("saved")
          }
        }
      }catch {
        print("Error with Json")
      }
    }
    dispatch_async(dispatch_get_main_queue()) {
      self.tableView(self.tableView, commitEditingStyle: .Insert, forRowAtIndexPath: self.newIndexPath!)
    }
  }
  
  func deleteCardHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode == 200) {
      print("status code: \(statusCode), Everything is okay!")
    } else {
      print("Failed to delete Card")
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
      destination.index = row
      destination.cards = cards
      
    } else if segue.identifier == "addCardSegue" {
      let navC: UINavigationController = segue.destinationViewController as! UINavigationController
      let addCardVC: AddCardViewController = navC.viewControllers[0] as! AddCardViewController
      addCardVC.topicId = self.topicId
    } else if segue.identifier == "UserTableViewSegue" {
      let navC: UINavigationController = segue.destinationViewController as! UINavigationController
        let usersTableVC: UsersTableViewController = navC.viewControllers[0] as! UsersTableViewController
        usersTableVC.topicId = topicId
    }
  }
}
