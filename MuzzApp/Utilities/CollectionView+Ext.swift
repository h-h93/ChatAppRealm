//
//  ScrollView+Ext.swift
//  MuzzApp
//
//  Created by hanif hussain on 04/04/2024.
//

import UIKit

extension UICollectionView {
    func scrollToBottom<T>(collection: [T]) {
        let lastItemIndex = IndexPath(item: collection.count - 1, section: 0)
        self.scrollToItem(at: lastItemIndex, at: .bottom, animated: true)
    }
    
}
