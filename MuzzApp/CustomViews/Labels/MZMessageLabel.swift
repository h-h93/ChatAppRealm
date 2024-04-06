//
//  MZMessageLabel.swift
//  MuzzApp
//
//  Created by hanif hussain on 31/03/2024.
//

import UIKit

class MZMessageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        backgroundColor = .clear
        textColor = UIColor.white
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
