//
//  MZMessageContainerView.swift
//  MuzzApp
//
//  Created by hanif hussain on 31/03/2024.
//

import UIKit

class MZAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
    }
}
