//
//  MembersTableViewController.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import UIKit

class MembersTableViewController: UITableViewController {
    
    
    
    let fb = FirebaseManager.shared
    var id: String!
    var group: Group!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var groupRef = fb.groupsRef.document(id)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddMemberDialog)
        
        )}
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // updateView()
            fb.groupRef.addSnapshotListener { (documentSnapshot, error) in
                
                if let error = error {
                    print("Error")
                    return
                }
                if !documentSnapshot!.exists{
                    print("might go back")
                    return
                }
                self.group = Group(documentSnapshot: documentSnapshot!)
                
    //            Decide if we can edit or not
                if (self.fb.currentUser!.uid == self.group?.owner){
                    
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(self.showAddMemberDialog))
                    
                }else{
                    self.navigationItem.rightBarButtonItem = nil
                }
                
                
                
                
                self.tableView.reloadData()
                }
            }
        
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            fb.groupListener.remove()
        }
        
        @objc func showAddMemberDialog(){
            
            
                let alertController = UIAlertController(title: "Add Member", message: "", preferredStyle: .alert)
                
                // configure
                alertController.addTextField { (textField) in
                    textField.placeholder = "Member to Add"
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
                    // Todo: Add a quote
                    let addMemberTextField = alertController.textFields![0] as UITextField
                    //            print(quoteTextField.text!)
                    //            print(movieTextField.text!)
    //                self.movieQuote?.quote = quoteTextField.text!
    //                self.movieQuote?.movie = movieTextField.text!
    //                self.updateView()
                    
                    self.fb.groupRef.updateData(["members": addMemberTextField.text!])
                    
                }
                alertController.addAction(submitAction)
                
                present(alertController, animated: true, completion: nil)
            
        }
}
