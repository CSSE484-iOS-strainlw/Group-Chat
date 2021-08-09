//
//  UserManager.swift
//  Group Chat
//
//  Created by Loki Strain on 8/8/21.
//

import Foundation

let kCollectionUsers = "Users"
let kKeyFirstName = "name"
let kKeyLastName = "photoUrl"


class UserManager {
    
    let fb = FirebaseManager.shared
    let fbAuth = FirebaseManager.auth
    
    static let shared = UserManager()
    
    private init(){
    }
    
    //Create
    func addNewUserMaybe(uid: String, firstName: String?, lastName: String?){
        // Get user to check exsistance
        // Add user only if they dont exsist
        
        let userRef = fb.usersRef.document(uid)
        userRef.getDocument { documentSnapshot, error in
            if let error = error{
                print("Error getting user\(error)")
                return
            }
            if let documentSnapshot = documentSnapshot{
                if documentSnapshot.exists{
                    print("There is already a user object for this auth user. Do Nothing")
                    return
                }else{
                    print("Creating a User with document id \(uid)")
                }
                userRef.setData([kKeyFirstName: firstName ?? "", kKeyLastName: lastName ?? ""])
            }
        }
    }
    //Read
    func beginListening(uid: String, changeListener: (() -> Void)?){
        let userRef = fb.usersRef.document(uid)
        userRef.addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error listening for user:\(error)")
                return
        }
            if let documentSnapshot = documentSnapshot {
                self.fb.userDocument = documentSnapshot
                changeListener?()
                
            }
        }
    }
    func stopListeing(){
        fb.userListener?.remove()
    }
    
    //Update
    func updateFirstName(firstName:String){
        let userRef = fb.usersRef.document(fb.currentUser!.uid)
        userRef.updateData([kKeyFirstName: firstName])
    }
    
    func updateLastName(lastName: String){
        let userRef = fb.usersRef.document(fb.currentUser!.uid)
        userRef.updateData([kKeyLastName: lastName])
    }
    
    //Getters
    var firstName: String {
        if let value = fb.userDocument?.get(kKeyFirstName){
                return value as! String
            }
        return ""
    }

    var lastName: String {
        if let value = fb.userDocument?.get(kKeyLastName){
                return value as! String
            }
        return ""
    }
    
}
