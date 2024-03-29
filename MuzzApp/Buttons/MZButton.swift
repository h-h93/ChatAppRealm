//
//  MZButton.swift
//  MuzzApp
//
//  Created by hanif hussain on 26/03/2024.
//

import UIKit

class MZButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(title: String, colour: UIColor, systemImageName: String?) {
        self.init()
        set(title: title, colour: colour, systemImageName: systemImageName)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configuration?.cornerStyle = .medium
        configuration = .tinted()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func set(title: String, colour: UIColor, systemImageName: String?) {
        configuration?.title = title
        configuration?.baseBackgroundColor = colour
        configuration?.baseForegroundColor = colour
        
        configuration?.image = UIImage(systemName: systemImageName ?? "")
        configuration?.imagePadding = 5
        configuration?.imagePlacement = .trailing
    }
}
