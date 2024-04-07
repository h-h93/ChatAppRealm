//
//  ChatVC+Ext.swift
//  MuzzApp
//
//  Created by hanif hussain on 05/04/2024.
//

import UIKit
import InputBarAccessoryView

extension ChatVC: InputBarAccessoryViewDelegate {
    override var inputAccessoryView: UIView? {
        get {
            return customInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func configureDataSource() {
        let padding: CGFloat = 32
        dataSource = UICollectionViewDiffableDataSource<MessageSectionHeader, ChatMessage>(collectionView: collectionView) { collectionView, indexPath, message in
            // Configure cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MZMessageCell.reuseID, for: indexPath) as! MZMessageCell
            cell.messageBubbleWidthAnchor?.constant = self.estimatedFrameForText(text: message.text).width + padding
            if message.author == self.recipient {
                cell.isOutgoing = false
                cell.messageTextLabel.text = message.text
            } else {
                cell.isOutgoing = true
                cell.messageTextLabel.text = message.text
            }
            return cell
        }
        configureHeader()
    }
    
    
    func configureHeader() {
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.reuseIdentifier, for: indexPath) as? CollectionHeaderView else { fatalError("Unable to dequeue now playing header view")}
                return self.configureCellDate(collectionHeaderView: header, index: indexPath.section)
            case UICollectionView.elementKindSectionFooter:
                return UICollectionReusableView()
            default:
                fatalError("Unable to dequeue reusable view or idnex out of range")
            }
        }
    }
    
    // I work out the height of each cell by checking the height for each of the messages text
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        let padding: CGFloat = 20
        if !messageHeader.isEmpty {
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let itemsAtSection = self.dataSource.snapshot().itemIdentifiers(inSection: section)
            height = estimatedFrameForText(text: itemsAtSection[indexPath.item].text).height
            return CGSize(width: view.frame.width, height: height + padding)
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard let user = RealmDBManager.shared.user?.profile.email else { return }
        sendingMessage = true
        let chatMessage = ChatMessage(author: user, recipient: self.recipient, text: text)
        Task (priority: .background) {
            do {
                try await RealmDBManager.shared.saveMessages(chatMessage: chatMessage)
            } catch {
                if let mzError = error as? MZError {
                    presentMZAlert(title: "Unable to post message", message: mzError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    
    func configureCellDate(collectionHeaderView: CollectionHeaderView, index: Int) -> CollectionHeaderView {
        collectionHeaderView.label.text = Date().formatStringToShortDateForCellHeader(date: messageHeader[index].date)
        return collectionHeaderView
    }
}
