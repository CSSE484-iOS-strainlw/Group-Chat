//
//  PressedLoginVC.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import UIKit

class PressedLoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var fb = FirebaseManager.shared
    var fbAuth = FirebaseManager.auth
    
    var loginViewController: LoginVC{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! LoginVC
    }
    let groupTableViewSegueIdentifier = "GroupTableViewSegueIdentifier"
    let mainPageSegueIdentifier = "MainPageSegueIdentifier"
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedLogin(_ sender: Any) {
        
        self.fbAuth.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: nil)
        
        
        dismiss(animated: true, completion: nil)
        loginViewController.performSegue(withIdentifier: groupTableViewSegueIdentifier, sender: loginViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    
}
