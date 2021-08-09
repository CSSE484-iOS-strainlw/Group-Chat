//
//  Message.swift
//  Group Chat
//
//  Created by Loki Strain on 8/8/21.
//

import Foundation

class Message {
    
    var message: String
    var author: String
    
    init(_ message: String,_  author: String) {
        self.message = message
        self.author = author
        
    }
    
    func changeMessage(_ newMessage: String) {
        self.message = newMessage
    }
    
    
}
