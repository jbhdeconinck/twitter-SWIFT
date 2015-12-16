//
//  MainViewController.swift
//  Twitter
//
//  Created by Alix on 15/12/2015.
//  Copyright © 2015 Alix. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var posts: [String: String] = [String: String]()
    

    var ref = Firebase(url: "https://twittermocker23.firebaseio.com/")
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
            var keys: Array = Array(self.posts.keys)
            cell.textLabel?.text = posts[keys[indexPath.row]] as String!
        
            return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            print(snapshot.value.objectForKey("Posts")) as! [String: String]
            print(self.posts)
            self.tableView.reloadData()
        
            
        })
        
    }

    
    @IBAction func logout(sender: AnyObject) {
        
        ref.unauth()
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
}
