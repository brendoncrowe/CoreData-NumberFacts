//
//  CreateUserViewController.swift
//  CoreData-NumberFacts
//
//  Created by Brendon Crowe on 5/3/23.
//

import UIKit

protocol CreateUserViewControllerDelegate: NSObject {
    func didCreateUser(_ createUserViewController: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public weak var delegate: CreateUserViewControllerDelegate?
    private var dateOfBirth: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDP()
    }
    
    private func configureDP() {
        datePicker.maximumDate = Date()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            print("missing user name")
            return
        }
        let date = datePicker.date
        let user = CoreDataManager.shared.createUser(name: userName, dob: date)
        delegate?.didCreateUser(self, user: user)
    }
}
