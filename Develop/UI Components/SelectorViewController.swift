//
//  SelectorViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/9/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class SelectorViewController: UIViewController {
    
    let tableView = UITableView(translates: false).then {
        $0.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
