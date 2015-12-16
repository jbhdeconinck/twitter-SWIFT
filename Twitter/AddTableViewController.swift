//
//  AddTableViewController.swift
//  Twitter
//
//  Created by Alix on 16/12/2015.
//  Copyright © 2015 Alix. All rights reserved.
//

import UIKit
class AddTableViewController: UITableViewController {
    
    var ref = Firebase(url: "https://twittermocker23.firebaseio.com/")
    
    @IBOutlet weak var done: UIBarButtonItem!
    
    @IBOutlet weak var postTextField: UITextField!
    
    @IBAction func done(sender: AnyObject) {
        
        ref.childByAppendingPath("Posts").childByAutoId().setValue(postTextField.text)
        ref.childByAppendingPath("users/\(ref.authData.uid)/post").childByAutoId().setValue(postTextField.text)
        
        self.performSegueWithIdentifier("finishAddingMessage", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("reload"),userInfo: nil,repeats: true)
        
        self.navigationItem.hidesBackButton = true
    }

}
