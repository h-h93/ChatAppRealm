//
//  ViewController.swift
//  MuzzApp
//
//  Created by hanif hussain on 26/03/2024.
//

import UIKit
import SwiftData
import RealmSwift

class MuzzChatVC: UIViewController {
    let loginTitleLabel = MZTitleLabel(textAlignment: .left, fontSize: 20)
    let loginTextField = MZTextField(frame: .zero)
    let loginButton = MZButton(title: "Login", colour: .systemRed, systemImageName: nil)
    var user: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureRegisterLoginView()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        loginTextField.textContentType = .emailAddress
        loginTextField.autocapitalizationType = .none
    }
    
    
    func configureRegisterLoginView() {
        view.addSubview(loginTitleLabel)
        loginTitleLabel.text = "Username: "
        view.addSubview(loginTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            loginTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            loginTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            loginTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            loginTextField.heightAnchor.constraint(equalToConstant: 60),
            
            loginButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    @objc func loginUser() {
        Task {
            do {
                try await RealmDBManager.shared.loginUser(username: loginTextField.text ?? "")
                self.user = RealmDBManager.shared.realmApp.currentUser?.id
                let chatView = ChatListVC(user: self.user)
                chatView.modalTransitionStyle = .crossDissolve
                chatView.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(chatView, animated: true)
            } catch {
                print("Failed to login")
            }
        }
    }
    
    
}

