//
//  MZCollectionView.swift
//  MuzzApp
//
//  Created by hanif hussain on 05/04/2024.
//

import UIKit

class MZCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
        
        register(MZMessageCell.self, forCellWithReuseIdentifier: MZMessageCell.reuseID)
        register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        alwaysBounceVertical = true
        keyboardDismissMode = .interactive
        let collectionViewPadding = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        let collectionScrollPadding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        contentInset = collectionViewPadding
        scrollIndicatorInsets = collectionScrollPadding
    }
    
}
