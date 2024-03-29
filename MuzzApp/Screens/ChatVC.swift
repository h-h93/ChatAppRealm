//
//  ChatVC.swift
//  MuzzApp
//
//  Created by hanif hussain on 29/03/2024.
//

import UIKit
import RealmSwift

class ChatVC: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let textView = UITextView()
    var recipient: String!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    convenience init(recipient: String) {
        self.init()
        self.recipient = recipient
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureScrollview()
        RealmDBManager.shared.saveMessages(message: "Hey there", recipient: recipient)
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureScrollview() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        contentView.addSubview(textView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 400),
            
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }

}
