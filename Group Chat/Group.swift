//
//  Group.swift
//  Group Chat
//
//  Created by Loki Strain on 8/8/21.
//

import Foundation

class Group {
    var memberEmails = [String]()
    var messages = [Message]()
    let owner: String
    var name: String
    var id: String?
    
    init(_ memberEmails: [String],_ owner: String,_ name: String) {
        self.memberEmails = memberEmails
        self.owner = owner
        self.name = name
    }
    
    init(_ id: String, _ memberEmails: [String],_ owner: String,_ name: String) {
        self.memberEmails = memberEmails
        self.owner = owner
        self.name = name
        self.id = id
    }
    
    func addMember(_ newMemberEmail: String) {
        self.memberEmails.append(newMemberEmail)
    }
    func removeMember(_ memberEmail: String){
        if self.memberEmails.contains(memberEmail){
            self.memberEmails.remove(at: self.memberEmails.firstIndex(of: memberEmail)!)
        } else {
            print("Member doesnt exsist in group")
        }
    }
    
    func removeMessage(_ messageIndex: Int){
        messages.remove(at: messageIndex)
    }
    
    func editMessage(_ messageIndex: Int,_ newMessage: String){
        messages[messageIndex].changeMessage(newMessage)
    }
    func addMessage(_ newMessage: String,_ author: String){
        messages.append(Message(newMessage, author))
    }
    
    
    
}
