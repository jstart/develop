//
//  ViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coach = CoachCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()) // SFSymbols hammer hammer.fill
        coach.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        let chat = ChatViewController()
        chat.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1) // bubble, elipsis.bubble, bubble.left bubble.right
        
        let profile = ProfileTableViewController(style: .grouped)
        profile.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2) // person.circle, person.crop

        viewControllers = [coach, chat, profile]
    }

}
