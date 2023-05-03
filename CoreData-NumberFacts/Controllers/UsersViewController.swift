//
//  UsersViewController.swift
//  CoreData-NumberFacts
//
//  Created by Brendon Crowe on 5/3/23.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "userCell"
    private let segueIdentifier = "createUserSegue"
    private let cellSecondaryText = "Birthday: "
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        fetchUsers()
    }
    
    private func configureTV() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let createUserVC = segue.destination as? CreateUserViewController else {
                fatalError("could not load CreateUserViewController")
            }
            createUserVC.delegate = self
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = user.name
        content.secondaryText = cellSecondaryText + (user.dob?.formatted(date: .abbreviated, time: .omitted))!
        cell.contentConfiguration = content
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersViewController: CreateUserViewControllerDelegate {
    func didCreateUser(_ createUserViewController: CreateUserViewController, user: User) {
        print("created user")
        users.append(user)
    }
}
