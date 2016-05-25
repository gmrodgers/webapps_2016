//
//  TopicsTableViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 24/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class TopicsTableViewController: UITableViewController {
  
    // MARK: Properties
    var topics = [Topic]()

    override func viewDidLoad() {
      super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
      navigationItem.leftBarButtonItem = editButtonItem()
      
      loadSampleData()
    }
  
  func loadSampleData() {
    let topic1 = Topic(name: "Compilers")
    let topic2 = Topic(name: "OS")
    topics += [topic1, topic2]
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
        return topics.count
    }
  
    // MARK: Actions
//  @IBAction func createNewTopicAlert(sender: UIBarButtonItem) {
//    // Create alert controller
//    let alert = UIAlertController(title: "Enter New Topic", message: "", preferredStyle: .Alert)
//    
//    //2. Add the text field. You can configure it however you need.
//    alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
//      textField.text = "Topic Name"
//    })
//    
//    //3. Grab the value from the text field, and print it when the user clicks OK.
//    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
//      let textField = alert.textFields![0] as UITextField
//      print("text: \(textField.text)")
//      let topic = Topic(name: textField.text!)
//      self.topics += [topic]
//    }))
//    
//    // 4. Present the alert.
//    self.presentViewController(alert, animated: true, completion: nil)
//  }
  

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      // Table view cells are reused and should be dequeued using a cell identifier.
      let cellIdentifier = "TopicsTableViewCell"
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TopicsTableViewCell
      
      // Fetches the appropriate meal for the data source layout.
      let topic = topics[indexPath.row]
      
      cell.topicLabel.text = topic.name
      
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
    }
    
    
  }

}
