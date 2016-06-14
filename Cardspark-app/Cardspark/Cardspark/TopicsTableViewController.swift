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
    dataServer.loadTopicsList(email, controller: self)

    self.refreshControl?.addTarget(self, action: #selector(TopicsTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
  }
  
  func handleRefresh(refreshControl: UIRefreshControl) {
    topics = []
    self.tableView.reloadData()
    dataServer.loadTopicsList(email, controller: self)

    refreshControl.endRefreshing()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
    let cellIdentifier = "TopicsTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TopicsTableViewCell
    if(searchActive){
      cell.topicLabel.text = filtered[indexPath.row].name
      let colour = getColour(filtered[indexPath.row].colour)
      cell.backgroundColor = colour
    } else {
      cell.topicLabel.text = topics[indexPath.row].name
      let colour = getColour(topics[indexPath.row].colour)
      cell.backgroundColor = colour
    }
    return cell
  }
  
  func getColour(colour : String) -> UIColor {
    switch colour {
    case "red":
      return UIColor.redColor()
    case "blue":
      return UIColor.blueColor()
    case "orange":
      return UIColor.orangeColor()
    case "purple":
      return UIColor.purpleColor()
    case "green":
      return UIColor.greenColor()
    default :
      return UIColor.whiteColor()
    }
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      deleteTopicFromServer(topics[indexPath.row])
      topics.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
    }
  }
  
  @IBAction func unwindToTopicsList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? NewTopicViewController, topic = sourceViewController.topic {
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
              if let colour = topic["colour"] as? String {
                newTopic.changeColour(colour)
              }
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
            if let colour = topic["colour"] as? String {
              newTopic.changeColour(colour)
            }
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
      let navCsecond: UINavigationController = tabBarVC.viewControllers?[1] as! UINavigationController
      let messagesVC: MessagesViewController = navCsecond.viewControllers[0] as! MessagesViewController
      let navCthird: UINavigationController = tabBarVC.viewControllers?[2] as! UINavigationController
      let quizVC: QuizViewController = navCthird.viewControllers[0] as! QuizViewController
      let topicIndex = tableView.indexPathForSelectedRow?.row
      messagesVC.topicId = topics[topicIndex!].id!
      cardTableVC.topicId = topics[topicIndex!].id!
      quizVC.topicId = topics[topicIndex!].id!
    }
  }
}
