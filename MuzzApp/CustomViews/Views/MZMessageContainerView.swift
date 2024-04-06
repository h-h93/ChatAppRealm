//
//  MZMessageContainerView.swift
//  MuzzApp
//
//  Created by hanif hussain on 31/03/2024.
//

import UIKit

class MZMessageContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
    }
}
