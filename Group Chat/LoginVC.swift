//
//  LoginVC.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import UIKit

class LoginVC: UIViewController{
    
    let fb = FirebaseManager.shared
    let fbAuth = FirebaseManager.auth
    let um = UserManager.shared
    let groupTableViewSegueIdentifier = "GroupTableViewSegueIdentifier"
    let pressedLoginIdentifier = "PressedLoginIdentifier"
    let pressedSignUpIdentifier = "PressedSignUpIdentifier"
    
    @IBAction func pressedLogin(_ sender: Any) {
        performSegue(withIdentifier: pressedLoginIdentifier, sender: self)

    }
    
    @IBAction func pressedSignUp(_ sender: Any) {
        performSegue(withIdentifier: pressedSignUpIdentifier, sender: self)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if fb.currentUser != nil {
            print("Already Signed in, Lognin Page")
            self.performSegue(withIdentifier: self.groupTableViewSegueIdentifier, sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fb.loginStartListening(self)
    }
    
    override func viewDidLoad() {
        
    }
    
    
}
