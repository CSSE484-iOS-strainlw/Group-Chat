//
//  MainSideNavController.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import UIKit

class MainSideNavController: UIViewController {
    
    let fb = FirebaseManager.shared
    let fbAuth = FirebaseManager.auth
    
    @IBAction func pressedLogOut(_ sender: Any) {
        
        if fbAuth.currentUser != nil {
        do{
            try fbAuth.signOut()
        } catch{
            print("Sign out Error")
        }
        
    }
    
    
}
}
