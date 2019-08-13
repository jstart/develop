//
//  ChatViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let messages = Message.localMessages()
        
        let label = UILabel()
        label.backgroundColor = .blue
        label.text = "You have \(messages.count) message\(messages.count == 1 ? "" : "s")"
        view.addSubview(label)
        
//        label.constrain((.leadingMargin, 20), (.topMargin, 20), toItem: view)
//        label.constrain((.width, 200), (.height, 20))
        
        label.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        }
        
//        label.snp.makeConstraints { (make) -> Void in
//            make.edges.equalTo(view)
//        }
    }

}
