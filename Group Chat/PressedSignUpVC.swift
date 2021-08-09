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
    var um = UserManager.shared
    
    var email = ""
    var password = ""
    var firstName = ""
    var lastName = ""
    
    var loginViewController: LoginVC{
        let navController = self.presentingViewController as! UINavigationController
        return navController.viewControllers.last as! LoginVC
    }
    let groupTableViewSegueIdentifier = "GroupTableViewSegueIdentifier"
    let mainPageSegueIdentifier = "MainPageSegueIdentifier"
    
    @IBAction func pressedSignUp(_ sender: Any) {
        
        
        email = emailTextField.text!
        password = passwordTextField.text!
        firstName = firstNameTextField.text!
        lastName = lastNametextField.text!
        
        fbAuth.createUser(withEmail: email, password: password) {authResult, error in
            if let error = error {
                print("Error Creating New User \(error)")
            }else{
                
                
                print("It Worked. New user created and sign in")
                self.loginViewController.performSegue(withIdentifier: self.groupTableViewSegueIdentifier, sender: self.loginViewController)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if self.fb.currentUser?.uid != nil{
            
            print(fb.currentUser!.uid)
        
            self.um.addNewUserMaybe(uid: self.fb.currentUser!.uid, firstName: firstName, lastName: lastName)
            
        }
    
    }
}
