//
//  ViewCardViewController.swift
//  Cardspark
//
//  Created by Martin Xu on 01/06/16.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit

class ViewCardViewController: UIViewController {
    
    var url = NSURL()
    var cards = [Card]()
    var index = Int()
    
    @IBAction func nextCard(sender: AnyObject) {
        print(index)
        if index > 0{
        index = index-1
        let urlReq = NSURLRequest(URL: cards[index].url)
        
        webview.loadRequest(urlReq)
        }
        
    }
    
    
    @IBAction func prevCard(sender: AnyObject) {
    }

    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        let urlReq = NSURLRequest(URL: url)
        webview.loadRequest(urlReq)
        
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
