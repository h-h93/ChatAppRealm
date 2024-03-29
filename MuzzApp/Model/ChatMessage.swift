//
//  ChatMessage.swift
//  MuzzApp
//
//  Created by hanif hussain on 29/03/2024.
//

import Foundation
import RealmSwift

class ChatMessage: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: String
    @Persisted var recipient: String
    @Persisted var text: String
    @Persisted var timestamp = Date()
    
    convenience init (author: String, recipient: String, text: String) {
        self.init()
        self.author = author
        self.recipient = recipient
        self.text = text
    }
}
