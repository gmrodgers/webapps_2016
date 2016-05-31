//
//  CardTableViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 26/05/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
    
    var cards = [Card]()

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

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CardTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardTableViewCell
            // Fetches the appropriate topic for the data source layout.
            cell.cardLabel.text = cards[indexPath.row].name
        return cell
        
    }
    
    func getCards() -> [Card] {
    
        let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        var pdfFiles = [NSURL]()
        
        
        do {
            let directoryUrls = try  NSFileManager.defaultManager().contentsOfDirectoryAtURL(documentsUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
            pdfFiles = directoryUrls.filter{ $0.pathExtension! == "pdf" }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        for file in pdfFiles {
            cards.append(Card(name: file.lastPathComponent!, url: file))
        }
        
        return cards
    }
}
