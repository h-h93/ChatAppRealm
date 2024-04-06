//
//  MZMessageBubbleView.swift
//  MuzzApp
//
//  Created by hanif hussain on 06/04/2024.
//

import UIKit

class MZMessageBubbleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(colour: UIColor, translatesAutoresizingMaskIntoConstraints: Bool) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        configure(colour: colour)
    }
    
    
    private func configure(colour: UIColor) {
        self.backgroundColor = colour.withAlphaComponent(0.8)
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }
}
