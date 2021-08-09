//
//  FirebaseManager.swift
//  Group Chat
//
//  Created by Loki Strain on 8/7/21.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let auth = Auth.auth()
    static let shared = FirebaseManager()
    static let store = Firestore.firestore()
    var groupsRef: CollectionReference!
    var groupsListener: ListenerRegistration!
    var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    var currentUser = Auth.auth().currentUser
    var usersRef: CollectionReference!
    var userDocument: DocumentSnapshot?
    var userListener: ListenerRegistration?
    
    private init(){
        
        self.currentUser = Auth.auth().currentUser
        self.groupsRef = Firestore.firestore().collection("Groups")
        self.usersRef = Firestore.firestore().collection("Users")
        
    }
    
    func startListening(_ viewController: MainTableViewController){
        if(groupsListener != nil){
            groupsListener.remove()
        }
        
        authStateListenerHandle = Auth.auth().addStateDidChangeListener{ (auth,user) in
            if (Auth.auth().currentUser == nil){
                print("There is no user")
                viewController.navigationController?.popViewController(animated: true)
            }else{
                print("Signed in")
            }
            
        }
        
        let query = groupsRef.order(by: "created", descending: true).limit(to: 50)
        
        groupsListener = query.addSnapshotListener( { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                viewController.groups.removeAll()
                querySnapshot.documents.forEach { (documentSnapshot) in

                    let id = documentSnapshot.documentID
                    let data = documentSnapshot.data()
                    let name = data["name"] as! String
                    let memberEmails = data["memberEmails"] as! [String]
                    let ownerEmail = data["ownerEmail"] as! String
                    
                    viewController.groups.append(Group(id, memberEmails, ownerEmail, name))
                }
                viewController.tableView.reloadData()
            }else {
                print(error!)
                return
            }
        })
    }
    
    func timeStamp() -> Timestamp{
       return Timestamp.init()
    }
    
    func getDocument(_ id: String) -> DocumentReference {
        return groupsRef.document(id)
    }
    
}
