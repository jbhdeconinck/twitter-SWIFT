//
//  ViewController.swift
//  Twitter
//
//  Created by Alix on 15/12/2015.
//  Copyright © 2015 Alix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref = Firebase(url: "https://twittermocker23.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        
        if ref.authData != nil {
            
            print("there is a user already signed in")
            self.performSegueWithIdentifier("loginAndSignUpComplete", sender: self)
            
        } else {
            
            print("you will have to login or sign up")
        }
        
    }
    
    @IBAction func login(sender: AnyObject) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            print("make sure to fill in all text fields")
        } else {
            ref.authUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { (error, authData) -> Void in
                
                if error != nil{
                    print(error)
                    print("there is an error with the given information")
                    
                } else {
                    
                    print("login success")
                    self.performSegueWithIdentifier("loginAndSignUpComplete", sender: self)
                }
            })
        }
    
    }
   
    @IBAction func signUp(sender: AnyObject) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            print("make sure to enter in each textfield")
        } else {
            ref.createUser(emailTextField.text, password: passwordTextField.text, withValueCompletionBlock: { (error, result) -> Void in
                
                if error != nil {
                    let myError = error
                    print(myError)
                    
                } else {
                    
                    print("success sign up!")
                    self.ref.authUser(self.emailTextField.text, password: self.passwordTextField.text, withCompletionBlock: { (error, authData) -> Void in
                        
                        if error != nil {
                            print(error)
                            print("there is an error with your given information")
                            
                        } else {
                            
//                            var userId = authData.uid
                            
                            let newUser = [
                                "provider": authData.provider,
                                "email": authData.providerData["email"] as? NSString as? String
                            ]
                            
//                            let fakePost = [
//                                
//                                "\(NSDate())": "this is my first fake post"
//                            
//                            ]
                         
                            self.ref.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(newUser)
//                            self.ref.childByAppendingPath("users/\(authData.uid)/post").setValue(fakePost)
                            
                            self.performSegueWithIdentifier("loginAndSignUpComplete", sender: self)
                        }
                        
                        
                    })
                }
            })
        }
        
    }
}

