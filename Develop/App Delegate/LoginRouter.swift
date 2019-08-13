//
//  LoginRouter.swift
//  Develop
//
//  Created by Truman, Christopher on 8/12/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation
import UIKit

struct LoginRouter {
    static func initialVC() -> UINavigationController {
        var vc: UIViewController?
        if !LoginController.shared.userLoggedIn() {
            vc = IntroViewController()
        } else {
            vc = HomeViewController()
        }
        
        guard let initialVC = vc else { fatalError() }
        let nav = initialVC.withNav()
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
}
