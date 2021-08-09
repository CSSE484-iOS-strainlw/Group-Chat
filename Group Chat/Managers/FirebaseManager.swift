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
    var groupRef: DocumentReference!
    var groupListener: ListenerRegistration!
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
    
    func loginStartListening(_ viewController: LoginVC){
        
        self.authStateListenerHandle = FirebaseManager.auth.addStateDidChangeListener{ (auth,user) in
            if self.currentUser?.uid == nil {
                print("There is no user")
                viewController.navigationController?.popViewController(animated: true)
            }else{
                print(self.currentUser?.uid)
                print("Signed in")
            }

        }
    }
    
    func groupStartListening(_ viewController: MainTableViewController){
        if(groupsListener != nil){
            groupsListener.remove()
        }
        self.authStateListenerHandle = FirebaseManager.auth.addStateDidChangeListener{ (auth,user) in
            if self.currentUser?.uid == nil {
                print("There is no user")
                viewController.navigationController?.popViewController(animated: true)
            }else{
                print(self.currentUser?.uid)
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
                    let author = data["author"] as! String
                    let name = data["name"] as! String
                    let memberEmails = data["memberEmails"] as! [String]
                    
                    
                    viewController.groups.append(Group(id, memberEmails, author, name))
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
