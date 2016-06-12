//
//  UsersTableViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 12/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController, UISearchBarDelegate {

  @IBOutlet weak var searchBar: UISearchBar!
  
  var topicId = Int()
  var users = [String]()
  var filtered = [String]()
  var dataServer = AppState.sharedInstance.dataServer
  var newIndexPath: NSIndexPath?
  var searchActive : Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    
    print (topicId)
    
    dataServer.loadUsersList(topicId, controller: self)
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
    filtered = users.filter({ (user) -> Bool in
      let tmp: NSString = user
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
    return users.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "UsersTableViewCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UsersTableViewCell
    if(searchActive){
      cell.userLabel.text = filtered[indexPath.row]
    }
    cell.userLabel.text = users[indexPath.row]
    print (cell.userLabel.text)
    return cell
    
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  func loadUsersListHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    print("status code: \(statusCode)")

    if (statusCode == 200) {
      do {
        let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as!NSDictionary
        if let users = dict.valueForKey("object") as? [[String: AnyObject]] {
          for user in users {
            if let name = user["email"] as? String{
              self.users.append(name)
              print ("Saved")
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
  
  @IBAction func done(sender: UIBarButtonItem) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}

