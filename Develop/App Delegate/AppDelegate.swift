//
//  AppDelegate.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginObserver = LoginObserver()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = LoginRouter.initialVC()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        loginObserver.startObserving(window)
        
        return true
    }

}

