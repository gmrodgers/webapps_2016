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
  
  override func viewDidLoad() {
      super.viewDidLoad()
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
      //navigationItem.leftBarButtonItem = editButtonItem()
      searchBar.delegate = self
      
      if let savedTopics = loadTopics() {
        topics += savedTopics
      } else {
//        loadSampleData()
        loadTopicsData()
      }
    }
  
//  func loadSampleData() {
//    let topic1 = Topic(name: "Compilers")
//    let topic2 = Topic(name: "OS")
//    topics += [topic1, topic2]
//  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  // MARK: SearchBar Delegate
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchActive = true;
  }
  
  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    searchActive = false;
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchActive = false;
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchActive = false;
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
      } else {
        // Fetches the appropriate topic for the data source layout.
        cell.topicLabel.text = topics[indexPath.row].name
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
            topics.removeAtIndex(indexPath.row)
            saveTopics()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  @IBAction func unwindToTopicsList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? NewTopicViewController, topic = sourceViewController.topic {
      // Add a new topic
      let newIndexPath = NSIndexPath(forRow: topics.count, inSection: 0)
      topics.append(topic)
      tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
      saveTopics()
    }
  }
  
  @IBAction func didTapDignOut(sender: UIBarButtonItem) {
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
  func saveTopics() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(topics, toFile: Topic.ArchiveURL.path!)
    if !isSuccessfulSave {
      print("Failed to save topics")
    }
  }
  
  func loadTopics() -> [Topic]? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(Topic.ArchiveURL.path!) as? [Topic]
    
  }
    
    func loadTopicsData() {
        NSLog("Connect with URL for loading topics")
        let urlString = "https://radiant-meadow-37906.herokuapp.com/topics"
        let url = NSURL(string: urlString)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do {
                    print("Everything is okay")
                    let topicsArray = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for topic in topicsArray {
                        
                        if let topicName = topic["name"] as? String {
                            let newTopic = Topic(name: topicName)
                            self.topics.append(newTopic)
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
        
        task.resume()
    }

}
