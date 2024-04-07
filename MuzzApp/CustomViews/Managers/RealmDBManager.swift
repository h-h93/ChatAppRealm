//
//  RealmDBManager.swift
//  MuzzApp
//
//  Created by hanif hussain on 27/03/2024.
//

import Foundation
import RealmSwift

@MainActor
class RealmDBManager {
    static let shared = RealmDBManager()
    let realmApp = App(id: "muzzchat-ymrif")
    var realm = try! Realm()
    @Published var user: RealmSwift.User?
    @Published var configuration: Realm.Configuration?
    @Published var messages: Results<ChatMessage>?
    
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
    
    
    func saveMessages(chatMessage: ChatMessage) async throws {
        guard (realmApp.currentUser?.profile.email) != nil else { return }
        do {
            try await realm.asyncWrite {
                realm.add(chatMessage)
            }
        } catch {
            throw MZError.unableToCompleteRequest
        }
    }
    
    
    func getChatMessages(recipient: String) async -> Results<ChatMessage>? {
        guard let user = user?.profile.email else { return nil }
        messages = realm.objects(ChatMessage.self).where {
            ($0.recipient == recipient) && ($0.author == user) || ($0.author == recipient) && ($0.recipient == user)
        }.sorted(byKeyPath: "timestamp", ascending: true)
        return messages ?? nil
    }
}
