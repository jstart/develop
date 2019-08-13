//
//  ProfileTableViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    let sections = ["Profile", "Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        
        tableView.registerClass(UserTableViewCell.self, UITableViewCell.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section != 0 ? sections[section] : nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(UserTableViewCell.self, indexPath: indexPath)
            cell.configure(User.localUser())
            return cell
        default:
            let cell = tableView.dequeue(UITableViewCell.self, indexPath: indexPath)
            cell.textLabel?.text = "Logout"
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            NotificationCenter.post(name: LoginObserver.LogoutNotification)
        }
    }
    
}
