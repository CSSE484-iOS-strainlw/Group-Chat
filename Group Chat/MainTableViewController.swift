//
//  MainTableViewController.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import UIKit

class MainTableViewController: UITableViewController{
    
    let mainSideMenuSegueIdentifier = "MainSideMenuSegueIdentifier"
    let groupCellIdentifier = "GroupCellIdentifier"
    var groups = [Group]()
    var fb = FirebaseManager.shared
    var fbAuth = FirebaseManager.auth
    let messagesSegueIdentifier = "MessagesSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddGroupDialog)
        
        )}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (fb.currentUser == nil) {
                print("There is no user")
                self.navigationController?.popViewController(animated: true)
            }else{
                print("Signed in")
            }
        
        fb.startListening(self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fb.groupsListener.remove()
        fbAuth.removeStateDidChangeListener(fb.authStateListenerHandle)
    }
    
    
    
    
    @IBAction func pressedSideView(_ sender: Any) {
        performSegue(withIdentifier: mainSideMenuSegueIdentifier, sender: self)
    }
    
    @objc func showAddGroupDialog(){
        let alertController = UIAlertController(title: "Create a new Group", message: "", preferredStyle: .alert)
        
        // configure
        alertController.addTextField { (textField) in
            textField.placeholder = "Group Title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Members (Seperated by comma)"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let submitAction = UIAlertAction(title: "Create Group", style: .default) { (action) in

            let nameTextField = alertController.textFields![0] as UITextField
            let membersTextField = alertController.textFields![1] as UITextField
            
            self.fb.groupsRef.addDocument(data: ["quote": nameTextField.text!,"name":membersTextField.text!, "created": self.fb.timeStamp, "author": self.fb.currentUser!.uid])
            
        }
        
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: groupCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = groups[indexPath.row].name
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        let group = groups[indexPath.row]
//        return fb.currentUser!.uid == group.owner
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            movieQuotes.remove(at: indexPath.row)
            //            tableView.reloadData()
            let groupToDelete = groups[indexPath.row]
            fb.groupsRef.document(groupToDelete.id!).delete()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == groupCellIdentifier{
//            if let indexPath = tableView.indexPathForSelectedRow{
//                                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
//                (segue.destination as! MessagesTableViewController).groupRef = fb.groupsRef.document(groups[indexPath.row].id!)
//            }
//        }
    }

    
}
