//
//  TopicsTableViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 24/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit
import Firebase

class TopicsTableViewController: UITableViewController, UISearchBarDelegate {
  
  // MARK: Properties
  @IBOutlet weak var searchBar: UISearchBar!
  
  var searchActive : Bool = false
  var topics = [Topic]()
  var filtered = [Topic]()
  var email = AppState.sharedInstance.userEmail!
  var dataServer = AppState.sharedInstance.dataServer
  var newIndexPath: NSIndexPath?
  
  let topicTableToCardTableSegueIdentifier = "CardTableViewSegue"
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    searchBar.delegate = self
    self.tableView.tableHeaderView = searchBar;
    
    dataServer.loadTopicsList(email, controller: self)
    
//    if let savedTopics = loadTopics() {
//      topics += savedTopics
//    } else {
//    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: SearchBar Delegate
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
    filtered = topics.filter({ (topic) -> Bool in
      let tmp: NSString = topic.name
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
    return topics.count
  }
  
  // MARK: Actions
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "TopicsTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TopicsTableViewCell
    if(searchActive){
        cell.topicLabel.text = filtered[indexPath.row].name
        cell.backgroundColor = filtered[indexPath.row].color
    } else {
      // Fetches the appropriate topic for the data source layout.
        cell.topicLabel.text = topics[indexPath.row].name
        cell.backgroundColor = topics[indexPath.row].color
    }
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
      deleteTopicFromServer(topics[indexPath.row])
      topics.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
    }
  }
  
  @IBAction func unwindToTopicsList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? NewTopicViewController, topic = sourceViewController.topic {
      // Add a new topic
      newIndexPath = NSIndexPath(forRow: topics.count, inSection: 0)
      saveTopicToServer(topic)
    }
  }
  
  @IBAction func didTapSignOut(sender: UIBarButtonItem) {
    let firebaseAuth = FIRAuth.auth()
    do {
      try firebaseAuth?.signOut()
      AppState.sharedInstance.signedIn = false
      dismissViewControllerAnimated(true, completion: nil)
    } catch let signOutError as NSError {
      print ("Error signing out: \(signOutError)")
    }
  }
  
  // MARK: NSCoding
  func saveTopicToServer(topic: Topic) {
    dataServer.createNewTopic(email, topic: topic, controller: self)
  }
  
  func deleteTopicFromServer(topic: Topic) {
    dataServer.deleteTopic(email, topic_id: topic.id!, controller: self)
  }
  
//  func saveTopics() {
//    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(topics, toFile: Topic.ArchiveURL.path!)
//    if !isSuccessfulSave {
//      print("Failed to save topics")
//    }
//  }
  
//  func loadTopics() -> [Topic]? {
//    return NSKeyedUnarchiver.unarchiveObjectWithFile(Topic.ArchiveURL.path!) as? [Topic]
//    
//  }
  
    func loadTopicsListHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
            do {
              let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as!NSDictionary
                if let topics = dict.valueForKey("object") as? [[String: AnyObject]] {
                    for topic in topics {
                        if let name = topic["name"] as? String, id = topic["id"] as? Int {
                          let newTopic = Topic(name: name)
                          newTopic.setId(id)
                          self.topics.append(newTopic)
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
  
  func createTopicHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode == 200) {
      do {
        let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as!NSDictionary
        if let topic = dict.valueForKey("object") as? [String: AnyObject] {
          if let name = topic["name"] as? String, id = topic["id"] as? Int {
            let newTopic = Topic(name: name)
            newTopic.setId(id)
            self.topics.append(newTopic)
            
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
  
  func deleteTopicHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode == 200) {
      print("status code: \(statusCode), Everything is okay!")
    } else {
      print("Failed to delete Topic")
    }
  }
  
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if  segue.identifier == topicTableToCardTableSegueIdentifier {
      let tabBarVC: UITabBarController = segue.destinationViewController as! UITabBarController
      let navC: UINavigationController = tabBarVC.viewControllers?.first as! UINavigationController
      let cardTableVC: CardTableViewController = navC.viewControllers[0] as! CardTableViewController
      let topicIndex = tableView.indexPathForSelectedRow?.row
      print(topicIndex)
      cardTableVC.topicId = topics[topicIndex!].id!
      AppState.sharedInstance.topic = topics[topicIndex!]
    }
  }
  
}
