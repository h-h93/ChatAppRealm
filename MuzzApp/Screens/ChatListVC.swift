//
//  ChatListVC.swift
//  MuzzApp
//
//  Created by hanif hussain on 27/03/2024.
//

import UIKit
import Realm

class ChatListVC: UIViewController {
    let tableView = MZTableView()
    var user: String!
    var userCount = 0
    var friendsList = [String: RLMUser]()
    
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
        getUsers()
    }
    
    
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    
    func getUsers() {
        Task() {
            userCount = RealmDBManager.shared.realmApp.allUsers.count - 1
            friendsList = RealmDBManager.shared.realmApp.allUsers
            friendsList.removeValue(forKey: RealmDBManager.shared.realmApp.currentUser!.id)
            tableView.reloadData()
        }
    }
    
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MZTableView.reuseID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MZTableView.reuseID, for: indexPath)
        cell.textLabel?.text = Array(friendsList)[indexPath.row].value.profile.email
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipient = Array(friendsList)[indexPath.row].value.profile.email else
        { return }
        let chatVC = ChatVC(recipient: recipient)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
}
