//
//  RealmDBManager.swift
//  MuzzApp
//
//  Created by hanif hussain on 27/03/2024.
//

import Foundation
import RealmSwift

enum MZError: String, Error {
    case unableToCreateUser = "Unable to create user"
}

class RealmDBManager {
    static let shared = RealmDBManager()
    let realmApp = App(id: "muzzchat-ymrif")
    var realm = try! Realm()
    @Published var user: RealmSwift.User?
    @Published var configuration: Realm.Configuration?
    @Published var messages: Results<ChatMessage>?
    
    @MainActor
    func loginUser(username: String) async throws {
        let credentials = Credentials.emailPassword(email: username, password: "Muzz123")
        
        do {
            user = try await realmApp.login(credentials: credentials)
            configuration = user?.flexibleSyncConfiguration(initialSubscriptions: { syncSubscriptionSet in
                if let _ = syncSubscriptionSet.first(named: "all-messages") {
                    return
                } else {
                    syncSubscriptionSet.append(QuerySubscription<ChatMessage>(name: "all-messages"))
                }
            }, rerunOnOpen: true)
            
            realm = try await Realm(configuration: configuration!, downloadBeforeOpen: .always)
            messages = realm.objects(ChatMessage.self).sorted(byKeyPath: "timestamp", ascending: true)
        } catch {
            throw MZError.unableToCreateUser
        }
    }
    
    
    func saveMessages(message messageString: String, recipient: String) {
        guard let author = realmApp.currentUser?.id else { return }
        let message = ChatMessage(author: author, recipient: recipient, text: messageString)
        
        do {
            try realm.write {
                realm.add(message)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func getMessages() {
        let messages = realm.objects(ChatMessage.self)
        
        print(messages)
    }
    
}
