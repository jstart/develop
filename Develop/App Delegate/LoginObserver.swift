//
//  LoginObserver.swift
//  Develop
//
//  Created by Truman, Christopher on 8/12/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation
import UIKit

class LoginObserver {
    weak var window: UIWindow?
    static let LogoutNotification = Notification.Name(rawValue: "Develop.Logout")
    static let RegisteredNotification = Notification.Name(rawValue: "Develop.Registered")

    func startObserving(_ window: UIWindow?) {
        self.window = window
        NotificationCenter.addObserver(name: LoginObserver.LogoutNotification) { [weak self] _ in
            LoginController.shared.logout()
            self?.displayVC()
        }
        
        NotificationCenter.addObserver(name: LoginObserver.RegisteredNotification) { [weak self] _ in
            LoginController.shared.login()
            self?.displayVC()
        }
    }
    
    func displayVC() {
        fadeOutAndReplace(with: LoginRouter.initialVC())
    }

    internal func fadeOutAndReplace(with vc: UINavigationController) {
        window?.rootViewController?.view.fadeOut(completion: { [weak self] in
            
            vc.setNavigationBarHidden(true, animated: false)
            vc.view.alpha = 0.0
            
            self?.window?.rootViewController = vc
            vc.view.fadeIn()
        })
    }
}
