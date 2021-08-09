//
//  PressedSignUpVC.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import UIKit

class PressedSignUpVC: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNametextField: UITextField!
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
    
    @IBAction func pressedSignUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNametextField.text!
        
        fbAuth.createUser(withEmail: email, password: password) {authResult, error in
            if let error = error {
                print("Error Creating New User \(error)")
            }else{
                
                print("It Worked. New user created and signe in")
                self.loginViewController.performSegue(withIdentifier: self.groupTableViewSegueIdentifier, sender: self.loginViewController)
            }
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
