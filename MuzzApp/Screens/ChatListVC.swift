//
//  ChatListVC.swift
//  MuzzApp
//
//  Created by hanif hussain on 27/03/2024.
//

import UIKit

class ChatListVC: UIViewController {
    let tableView = UITableView()
    var user: String!
    var userCount = 0
    var friendsList = [String]()
    
    init(user: String) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        RealmDBManager.shared.getMessages()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
        Task() {
            userCount = RealmDBManager.shared.realmApp.allUsers.count
            tableView.reloadData()
        }
    }
    
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Array(RealmDBManager.shared.realmApp.allUsers)[indexPath.row].value.profile.email
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipient = Array(RealmDBManager.shared.realmApp.allUsers)[indexPath.row].value.id 
        let chatVC = ChatVC(recipient: recipient)
        navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
}
