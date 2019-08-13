//
//  LoginController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/12/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation

class LoginController {
    
    var user: User?
    
    internal static let Login_Key = "Truman.userLoggedIn"
    
    static let shared = LoginController()
    
    init() {
        if userLoggedIn() {
            user = User.localUser()
        }
    }
    
    static func keychainCredentials() -> (email: String, password: String)? {
        return ("", "")
    }
    
    static func persistCredentials(_ :(email: String, password: String)) {
        
    }
    
    func userLoggedIn() -> Bool {
        return Defaults.object(forKey: LoginController.Login_Key) as? Bool ?? false
    }
    
    func login() {
        user = User.localUser()
        Defaults.set(true, forKey: LoginController.Login_Key)
    }

    func logout() {
        user = nil
        Defaults.set(false, forKey: LoginController.Login_Key)
    }
}
