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
    let um = 
    let mainPageSegueIdentifier = "MainPageSegueIdentifier"
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
            print("Already Signed in")
            self.performSegue(withIdentifier: self.mainPageSegueIdentifier, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == mainPageSegueIdentifier{
            print("Checking for user \(fb.currentUser!.uid)")
            UserManager.shared.addNewUserMaybe(uid: Auth.auth().currentUser!.uid, name: Auth.auth().currentUser!.displayName, photoUrl: Auth.auth().currentUser!.photoURL?.absoluteString ?? "")
        }
    }
    
    
    
}
