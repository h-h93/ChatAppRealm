//
//  ChatVC.swift
//  MuzzApp
//
//  Created by hanif hussain on 29/03/2024.
//
import UIKit
import RealmSwift
import InputBarAccessoryView

class ChatVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var dataSource: UICollectionViewDiffableDataSource<MessageSectionHeader, ChatMessage>!
    var recipient: String!
    var messageToken: NotificationToken?
    var messages: Results<ChatMessage>!
    var messageHeader = [MessageSectionHeader]()
    var sendingMessage = false
    let customInputView = MZInputAccessoryView()
    var messageList = [MessageSectionHeader: [ChatMessage]]()
    let layout = UICollectionViewFlowLayout()
    let emptyStateView = MZEmptyStateView(message: "Nothing to see here... Yet.")
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: self.layout)
        self.layout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: 50)
    }
    
    
    convenience init(recipient: String) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.recipient = recipient
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        messageToken?.invalidate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadMessages()
        configureDataSource()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
        let collectionView = MZCollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView = collectionView
        customInputView.delegate = self
        self.collectionView.dataSource = dataSource
    }
    
    
    func loadMessages() {
        Task {
            messages = await RealmDBManager.shared.getChatMessages(recipient: recipient)
            messageToken = messages.observe { changes in
                switch changes {
                case .initial:
                    // Initial data loaded (may be empty)
                    let message = Array(self.messages.map { $0 })
                    self.updateUI(with: message)
                case .update(_, let deletions, let insertions, let modifications):
                    // Handle updates to the collection
                    let message = Array(self.messages.map { $0 })
                    self.updateUI(with: message)
                case .error(let error):
                    self.presentMZAlert(title: "Oops", message: "Unable to download messages", buttonTitle: "Ok")
                }
            }
        }
    }
    
    // start the process to update our UI with new messages
    func updateUI(with chatMessages: [ChatMessage]) {
        if !chatMessages.isEmpty {
            messageHeader.removeAll()
            emptyStateView.removeFromSuperview()
            // group messages into a temporary dictionary based on their date (after we format it)
            let messagesByDateTime = Dictionary(grouping: chatMessages) { (element) -> Date in
                let date = Date().formatDateToString(date: element.timestamp)
                let simplifiedDate = Date().formatStringToShortDate(string: date)
                return simplifiedDate
            }
            // sort the temporary dictionary keys and create messages header and append to our dictionary and array
            let sortedKeys = messagesByDateTime.keys.sorted()
            sortedKeys.forEach { (key) in
                let header = MessageSectionHeader(date: key)
                messageHeader.append(header)
                let value = messagesByDateTime[key]
                messageList[header] = value ?? []
            }
            self.updateDataSource()
        } else {
            emptyStateView.frame = view.frame
            view.addSubview(emptyStateView)
        }
    }
    
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<MessageSectionHeader, ChatMessage>()
        messageHeader.forEach { key in
            snapshot.appendSections([key])
            snapshot.appendItems(messageList[key] ?? [], toSection: key)
            snapshot.reloadItems(messageList[key] ?? [])
        }
        processSnapshot(snapshot: snapshot)
    }
    
    
    func processSnapshot(snapshot: NSDiffableDataSourceSnapshot<MessageSectionHeader, ChatMessage>) {
        DispatchQueue.main.async {
            if self.sendingMessage {
                self.collectionView.scrollToBottom(snapshot: self.dataSource.snapshot())
                self.customInputView.animateMessageLabel { _ in
                    self.dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)
                    self.collectionView.scrollToBottom(snapshot: snapshot)
                    self.customInputView.inputTextView.text = nil
                    self.sendingMessage = false
                }
            } else {
                self.dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)
                self.collectionView.scrollToBottom(snapshot: snapshot)
            }
        }
    }
}

